class Api::V1::BaseController < ApplicationController
  include Knock::Authenticable

  before_action :authenticate_user

  rescue_from ActiveRecord::RecordInvalid,
    with: :render_unprocessable_entity_response

  rescue_from ActionController::ParameterMissing,
    with: :render_parameter_missing_response

  rescue_from ActiveRecord::RecordNotFound,
    with: :render_not_found_response

  private

  # Overriding Knock's default response for an invalid JWT
  def unauthorized_entity(_exception)
    json = {
      errors: [
        {
          status: 401,
          title:  'Unauthorized',
          detail: 'The client lacks sufficient authorization'
        }
      ]
    }

    render json: json, status: :unauthorized
  end

  def render_not_found_response(_exception)
    json = {
      errors: [
        status: 404,
        title:  'Not Found',
        detail: 'The requested resource could not be found'
      ]
    }

    render json: json, status: :not_found
  end

  def render_parameter_missing_response(exception)
    json = {
      errors: [
        {
          status: 422,
          title:  'Parameter Missing',
          detail: "Expected parameter is missing or the value is empty: #{exception.param}"
        }
      ]
    }

    render json: json, status: :unprocessable_entity
  end

  def render_unprocessable_entity_response(exception)
    errors = exception.record.errors.full_messages.map do |error_message|
      {
        status: 422,
        title:  'Validation Failed',
        detail: error_message
      }
    end

    json = { errors: errors }

    render json: json, status: :unprocessable_entity
  end
end
