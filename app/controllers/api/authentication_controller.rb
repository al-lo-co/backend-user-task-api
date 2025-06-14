# frozen_string_literal: true

module Api
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate, only: :login

    def login
      user = User.find_by(email: params[:email])
      authenticated_user = user&.authenticate(params[:password])

      if authenticated_user
        render json: authenticated_user, included_token: true, status: :ok
      else
        render json: { error: "unauthorized" }, status: :unauthorized
      end
    end
  end
end
