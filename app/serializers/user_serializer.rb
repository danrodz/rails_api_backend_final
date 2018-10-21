class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :image_url

  def image_url
    instance_options[:get_image_url].call(object.image)
  end
end
