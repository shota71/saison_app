module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      def auth
        @auth_user = User.find(current_api_v1_user.id)
        render json: {status: 'SUCCESS', message: 'Loaded the auth user', data: @auth_user }
      end

        def show
          render json: { status: 'SUCCESS', message: 'Loaded the user', data: @user }
        end

        def set_user
          @user = User.find(params[:id])
        end
    end
  end
end
