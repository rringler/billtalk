class Api::V1::SessionsController < Knock::AuthTokenController
  private

  # Knock normally introspects the Controller name, but we're using a
  # non-standard name, so we'll override this method.
  def entity_name
    'User'
  end
end
