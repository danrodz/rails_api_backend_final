class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def profile
    render json: current_user, status: :accepted
  end

  def get_image_url
    ->(image) do
      begin
        url_for(image)
      rescue Module::DelegationError
        ''
      end
    end
  end

  def create
    @user = User.create!(user_params)
    if @user.valid?
      # @image_url = get_image_url.call(@user.image)
      @token = encode_token({ user_id: @user.id })
      render json: @user, get_image_url: get_image_url, jwt: @token, status: :created
      # render json: { user: UserSerializer.new(@user), jwt: @token, image_url: @image_url}, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.permit(:username, :user, :password, :image)
  end
end
