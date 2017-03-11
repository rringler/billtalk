require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe '#create' do
    let(:expected_jwt) { user.send(:generate_token) }
    let(:email)        { user.email }
    let(:password)     { user.password }
    let(:params)       { { auth: { email: email, password: password } } }
    let(:json)         { JSON.parse(response.body) }

    subject { post(:create, params: params) }

    context 'with valid credentials' do
      let(:user) { FactoryGirl.create(:user) }

      it 'returns a successful status code' do
        is_expected.to have_http_status(:created)
      end

      it 'returns a valid JWT' do
        Timecop.freeze do
          subject

          expect(json['jwt']).to eq(expected_jwt)
        end
      end
    end

    context 'with invalid credentials' do
      let(:user) { FactoryGirl.build(:user) }

      it 'returns a not found status code' do
        is_expected.to have_http_status(:not_found)
      end
    end
  end
end
