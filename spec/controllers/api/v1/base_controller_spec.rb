require 'rails_helper'

RSpec.describe Api::V1::BaseController, type: :controller do
  controller do
    def index; end
  end

  subject { get(:index) }

  context 'for authenticated endpoints' do
    context 'when unauthorized' do
      let(:json) { JSON.parse(subject.body, symbolize_names: true) }

      it 'returns an :unauthorized status code' do
        is_expected.to have_http_status(:unauthorized)
      end

      it 'returns a proper JSON response' do
        expect(json[:errors]).to contain_exactly(
          status: 401,
          title:  'Unauthorized',
          detail: 'The client lacks sufficient authorization'
        )
      end
    end
  end
end
