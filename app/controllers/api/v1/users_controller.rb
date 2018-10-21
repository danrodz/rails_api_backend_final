class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def profile
    @user = current_user
    @image_url = get_image_url
    @token = get_token
    render json: @user, get_image_url: @image_url, get_token: @token
  end

  def create
    @user = User.create!(user_params)
    if @user.valid?
      @image_url = get_image_url
      @token = get_token
      render json: @user, get_image_url: @image_url, get_token: @token, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.permit(:username, :user, :password, :image)
  end
end
