module Api
  module V1
class FavoritesController < ApplicationController
  # before_action :authenticate_api_v1_user!
  def create
    @post_favorite = Favorite.new(user_id: current_api_v1_user.id, post_id: params[:post_id])
    @post_favorite.save
    # redirect_to post_path(params[:post_id])
  end

  def destroy
    @post_favorite = Favorite.find_by(user_id: current_api_v1_user.id, post_id: params[:post_id])
    @post_favorite.destroy
    # redirect_to post_path(params[:post_id])
  end
end
end
end
