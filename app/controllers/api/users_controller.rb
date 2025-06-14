module Api
  class UsersController < ApplicationController
    before_action :set_user, only: [ :update, :show, :destroy ]

    def index
      render json: User.all, status: :ok
    end

    def show
      if @user
        render json: @user, status: :ok
      else
        render status: :not_found
      end
    end

    def create
      user = User.new(user_params)

      if user.save!
        render json: user, status: :created
      else
        render json: { errors: user.errors }, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render json: @user, status: :ok
      else
        render json: { errors: @user.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy

      head :no_content
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :full_name, :role)
    end

    def set_user
      @user ||= User.find(params[:id])
    end
  end
end
