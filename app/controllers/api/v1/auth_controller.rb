class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: user_login_params[:username])
    if @user && @user.authenticate(user_login_params[:password])
      @token = get_token
      @image_url = get_image_url
      render json: @user, get_token: @token, get_image_url: @image_url
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def user_login_params
    params.permit(:username, :password, :image, :user)
  end
end
