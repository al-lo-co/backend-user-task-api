module AuthenticationHelper
  def token_generator(id)
    JWT.encode(id, ENV['AUTHENTICATION_TOKEN'])
  end

  def valid_headers(user)
    {
      'Authorization' => "Bearer #{token_generator(user.id)}",
      'Content-Type' => 'application/json'
    }
  end
end
