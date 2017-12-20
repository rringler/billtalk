require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe '#create', authenticated: false do
    let(:params) { {} }
    let(:json)   { JSON.parse(subject.body, symbolize_names: true) }

    subject { post(:create, params: params) }

    context 'with valid credentials' do
      let(:user)         { FactoryBot.create(:user) }
      let(:email)        { user.email }
      let(:password)     { user.password }
      let(:params)       { { auth: { email: email, password: password } } }
      let(:expected_jwt) { user.send(:generate_token) }

      # it { is_expected.to have_http_status(:created) }

      # it_behaves_like 'a json response'

      it 'returns a proper JSON response' do
        Timecop.freeze do
          expect(json[:token]).to eq(expected_jwt)
        end
      end
    end

    # context 'with invalid credentials' do
    #   let(:user)     { FactoryBot.build(:user) }
    #   let(:email)    { user.email }
    #   let(:password) { user.password }
    #   let(:params)   { { auth: { email: email, password: password } } }

    #   it { is_expected.to have_http_status(:not_found) }

    #   it_behaves_like 'a json response'

    #   it 'returns a proper JSON response' do
    #     expect(json[:errors]).to contain_exactly(
    #       status: 404,
    #       title:  'Not Found',
    #       detail: 'An account with the provided email and password could not be found'
    #     )
    #   end
    # end
  end
end
