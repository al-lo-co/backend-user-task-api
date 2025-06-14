# frozen_string_literal: true

# Error handling
module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :standard_error
    rescue_from ActionController::ParameterMissing, with: :missing_parameter
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
    rescue_from JWT::VerificationError, with: :invalid_token
    rescue_from JWT::DecodeError, with: :decode_error
  end

  private

  def standard_error(exception)
    render json: { error: exception.message }, status: :bad_request
  end

  def missing_parameter(exception)
    render json: { error: exception.exception.message }, status: :bad_request
  end

  def record_not_found(exception)
    render json: { error: exception.exception.message }, status: :not_found
  end

  def invalid_token(exception)
    render json: { error: exception.exception.message }, status: :unauthorized
  end

  def decode_error(exception)
    render json: { error: exception.exception.message }, status: :bad_request
  end

  def handle_invalid_record(exception)
    render json: { errors: exception.exception.message }, status: :unprocessable_entity
  end
end
