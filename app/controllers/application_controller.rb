class ApplicationController < ActionController::API
  include ErrorHandling

  before_action :authenticate

  private

  def authenticate
    authorization_header = request.headers["Authorization"]
    token = authorization_header.split(" ").last if authorization_header
    decoded_token = JWT.decode(token, ENV["AUTHENTICATION_TOKEN"])[0]

    User.find(decoded_token)
  end
end
