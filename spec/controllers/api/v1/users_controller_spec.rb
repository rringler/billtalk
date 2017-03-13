require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe '#create', authenticated: false do
    let(:params) { {} }
    let(:json)   { JSON.parse(subject.body, symbolize_names: true) }

    subject { post(:create, params: params) }

    context 'when successful' do
      let(:user_attrs) { FactoryGirl.attributes_for(:user) }
      let(:params)     { { user: user_attrs } }

      it 'returns a successful status code' do
        is_expected.to have_http_status(:ok)
      end

      it 'creates a new user with the correct attributes' do
        expect { subject }.to change { User.count }.by(1)

        created_user  = User.last
        created_attrs = created_user.attributes.with_indifferent_access

        expect(created_attrs).to include(user_attrs.slice(:email))
      end

      it 'returns a proper JSON response' do
        Timecop.freeze do
          expect(json.dig(:data, :attributes)).to eq(
            email: User.last.email,
            token: User.last.send(:generate_token)
          )
        end
      end
    end

    context 'when unsuccessful' do
      let!(:existing_user) { FactoryGirl.create(:user) }
      let(:existing_email) { existing_user.email }
      let(:user_attrs)     { FactoryGirl.attributes_for(:user, email: existing_email) }
      let(:params)         { { user: user_attrs } }

      it 'returns an :unprocessable_entity status code' do
        is_expected.to have_http_status(:unprocessable_entity)
      end

      it 'returns a proper JSON response' do
        expect(json[:errors]).to contain_exactly(
          status: 422,
          title:  'Validation Failed',
          detail: 'Email has already been taken'
        )
      end
    end
  end

  describe '#show', authenticated: false do
    let(:params) { { id: -1 } }
    let(:json)   { JSON.parse(subject.body, symbolize_names: true) }

    subject { get(:show, params: params) }

    context 'when the requested user exists' do
      let(:user)   { FactoryGirl.create(:user) }
      let(:params) { { id: user.id } }

      it 'returns a :successful status code' do
        is_expected.to have_http_status(:ok)
      end

      it 'returns a proper JSON response' do
        expect(json.dig(:data, :id)).to         eq(user.id.to_s)
        expect(json.dig(:data, :attributes)).to eq(email: user.email)
      end
    end

    context 'when the requested user does not exists' do
      let(:params) { { id: -1 } }

      it 'returns a :not_found status code' do
        is_expected.to have_http_status(:not_found)
      end

      it 'returns a proper JSON response' do
        expect(json.dig(:errors)).to contain_exactly(
          status: 404,
          title:  'Not Found',
          detail: 'The requested resource could not be found'
        )
      end
    end
  end

  describe '#update', authenticated: true do
    let(:user)      { FactoryGirl.create(:user) }
    let(:email)     { user.email }
    let(:new_email) { "new_#{email}" }
    let(:params)    { { id: user.id, user: { email: new_email } } }
    let(:json)      { JSON.parse(subject.body, symbolize_names: true) }

    subject { post(:update, params: params) }

    context 'when successful' do
      it 'returns a successful status code' do
        is_expected.to have_http_status(:ok)
      end

      it 'updates the user' do
        expect { subject }.to change {
          user.reload.email
        }.from(email).to(new_email)
      end

      it 'returns a proper JSON response' do
        expect(json.dig(:data, :attributes)).to eq(
          email: new_email
        )
      end
    end
  end

  describe '#destroy', authenticated: true do
    let(:user)   { FactoryGirl.create(:user) }
    let(:params) { { id: user.id } }
    let(:json)   { JSON.parse(subject.body, symbolize_names: true) }

    subject { post(:destroy, params: params) }

    context 'when successful' do
      it 'returns a successful status code' do
        is_expected.to have_http_status(:ok)
      end

      it 'destroys the user record' do
        expect { subject }.to change { User.count }.by(-1)
      end

      it 'returns a proper JSON response' do
        expect(json.dig(:data, :id)).to         eq(user.id.to_s)
        expect(json.dig(:data, :attributes)).to eq(email: user.email)
      end
    end
  end
end
