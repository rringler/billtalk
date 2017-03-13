RSpec.configure do |rspec|
  # This config option will be enabled by default on RSpec 4,
  # but for reasons of backwards compatibility, you have to
  # set it on RSpec 3.
  #
  # It causes the host group and examples to inherit metadata
  # from the shared context.
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context 'with authentication token', shared_context: :metadata do
  let(:user)  { FactoryGirl.create(:user) }
  let(:token) { Knock::AuthToken.new(payload: { sub: user.id }).token }

  before { request.headers['Authorization'] = "Bearer #{token}" }
end

RSpec.configure do |rspec|
  rspec.include_context 'with authentication token', authenticated: true
end
