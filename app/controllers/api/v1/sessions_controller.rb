class Api::V1::SessionsController < Knock::AuthTokenController
  rescue_from ActiveRecord::RecordNotFound,
    with: :render_not_found_response

  rescue_from ActionController::ParameterMissing,
    with: :render_parameter_missing_response

  def create
    render status: :created, json: json
  end

  private

  # Knock normally introspects the Controller name, but we're using a
  # non-standard name, so we'll override this method.
  def entity_name
    'User'
  end

  def json
    {
      data: {
        attributes: {
          token: auth_token.token
        }
      }
    }
  end

  # Overriding Knock's default response for invalid credentials
  def render_not_found_response
    json = {
      errors: [
        {
          status: 404,
          title:  'Not Found',
          detail: 'An account with the provided email and password could not be found'
        }
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
end
