module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[show update destroy]
      # before_action :authenticate_api_v1_user!, only: [:index]

      def like
        @post_favorite = Favorite.new(user_id: current_api_v1_user.id, post_id: params[:post_id])
        @post_favorite.save
        # redirect_to post_path(params[:post_id])
      end

      def unlike
        @post_favorite = Favorite.find_by(user_id: current_api_v1_user.id, post_id: params[:post_id])
        @post_favorite.destroy
        # redirect_to post_path(params[:post_id])
      end

      def index
        posts = Post.order(created_at: :desc)
        @items = posts.as_json(include: { images: { only: [:url] }, user: {} }).map do |post|
          post.merge({ likes_count: post.favorites.count })
        end
        post_like_ranks = Post.joins('LEFT OUTER JOIN favorites ON posts.id = favorites.post_id')
                              .select('posts.*, COUNT(favorites.id) as likes_count')
                              .group('posts.id')
                              .order('likes_count DESC')
                              .as_json(include: { images: { only: [:url] }, user: {} })
        render json: { status: 'SUCCESS', message: 'Loaded posts', data: @items, post_like_ranks: post_like_ranks}
      end

      def test
        posts = Post.order
        @items = posts.as_json(include: { images: { only: [:url] } })
      end

      def show
        # @isLiked = @post.favorite?(api_v1_current_user)
        @isLiked = nil;
        if current_api_v1_user
          @isLiked = @post.favorite?(current_api_v1_user)
        end
        @likes_count = Favorite.where(post_id: @post.id).count
        @item = @post.as_json(include: { images: { only: [:url] }, user: {} })
        render json: { status: 'SUCCESS', message: 'Loaded the post', data: @item, isLiked: @isLiked, likesCount: @likes_count }
      end

      def create
        res = Cloudinary::Uploader.upload(
          params[:url],
          folder: 'saison'
        )
        post = Post.new(post_params)
        post.user_id = current_api_v1_user.id
        @is_save_post = post.save
        image = Image.new(post_id: post.id, url: res['secure_url'])
        @is_save_image = image.save
        if @is_save_post && @is_save_image
          render json: { status: 'SUCCESS', data: post, image: image }
        else
          render json: { status: 'ERROR', data: post.errors }
        end
      end

      def destroy
        @post.destroy
        render json: { status: 'SUCCESS', message: 'Deleted the post', data: @post }
      end

      def update
        if @post.update(post_params)
          render json: { status: 'SUCCESS', message: 'Updated the post', data: @post }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @post.errors }
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.permit(:title, :body)
      end

      def image_params
        params.permit(:post_id, :url)
      end
    end
  end
end
