module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]

      def index
        posts = Post.order(created_at: :desc)
        @items = posts.as_json(:include => {:images => {:only => [:url]}})

        render json: { status: 'SUCCESS', message: 'Loaded posts', data: @items }
      end

      def show
        render json: { status: 'SUCCESS', message: 'Loaded the post', data: @post }
      end

      def new
        @post = Post.new
        @tag = @post.images.new
      end

      def create
        post = Post.new({title: params[:title], body: params[:body]})
        image = Image.new({post_id: params[:post_id], url: params[:url]})
        if post.save && image.save
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
        params.require(:post).permit(:title, :body, images_attributes: [:post_id, :url])
      end
    end
  end
end
