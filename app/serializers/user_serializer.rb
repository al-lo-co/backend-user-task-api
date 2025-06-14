class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :role

  attribute :token, if: :included_token?

  has_many :tasks

  def included_token?
    instance_options[:included_token]
  end

  def token
    JWT.encode(object.id, ENV["AUTHENTICATION_TOKEN"])
  end
end
