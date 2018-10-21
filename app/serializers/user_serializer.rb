class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :image_url, :jwt

  def image_url
    instance_options[:get_image_url].call(@object.image)
  end

  def jwt
    instance_options[:get_token].call(@object.id)
  end
end
