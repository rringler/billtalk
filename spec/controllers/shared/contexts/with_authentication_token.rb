RSpec.shared_context 'with authentication token', shared_context: :metadata do
  let(:user)  { FactoryBot.create(:user) }
  let(:token) { Knock::AuthToken.new(payload: { sub: user.id }).token }

  before { request.headers['Authorization'] = "Bearer #{token}" }
end

RSpec.shared_examples 'authentication failure' do
  context 'when authentication fails' do
    let(:token) { nil }

    it { is_expected.to have_http_status(:unauthorized) }

    it_behaves_like 'a json response'
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'with authentication token', authenticated: true
  rspec.include_context 'authentication failure',    authenticated: true
end
