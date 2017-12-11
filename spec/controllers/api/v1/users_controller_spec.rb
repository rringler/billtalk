require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe '#create', authenticated: false do
    let(:params) { {} }
    let(:json)   { JSON.parse(subject.body, symbolize_names: true) }

    subject { post(:create, params: params) }

    context 'when successful' do
      let(:user_attrs) { FactoryBot.attributes_for(:user) }
      let(:params)     { { user: user_attrs } }

      it { is_expected.to have_http_status(:ok) }

      it 'creates a new User record' do
        expect { subject }.to change { User.count }.by(1)
      end

      it_behaves_like 'a json response'
    end

    context 'when unsuccessful' do
      let!(:existing_user) { FactoryBot.create(:user) }
      let(:existing_email) { existing_user.email }
      let(:user_attrs)     { FactoryBot.attributes_for(:user, email: existing_email) }
      let(:params)         { { user: user_attrs } }

      it { is_expected.to have_http_status(:unprocessable_entity) }

      it_behaves_like 'a json response'
    end
  end

  describe '#show', authenticated: false do
    let(:params) { { id: -1 } }
    let(:json)   { JSON.parse(subject.body, symbolize_names: true) }

    subject { get(:show, params: params) }

    context 'when the requested user exists' do
      let(:user)   { FactoryBot.create(:user) }
      let(:params) { { id: user.id } }

      it { is_expected.to have_http_status(:ok) }

      it_behaves_like 'a json response'
    end

    context 'when the requested user does not exists' do
      let(:params) { { id: -1 } }

      it { is_expected.to have_http_status(:not_found) }

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
    let(:user)      { FactoryBot.create(:user) }
    let(:email)     { user.email }
    let(:new_email) { "new_#{email}" }
    let(:params)    { { id: user.id, user: { email: new_email } } }
    let(:json)      { JSON.parse(subject.body, symbolize_names: true) }

    subject { post(:update, params: params) }

    context 'when successful' do
      it { is_expected.to have_http_status(:ok) }

      it 'updates the user' do
        expect { subject }.to change {
          user.reload.email
        }.from(email).to(new_email)
      end

      it_behaves_like 'a json response'
    end
  end

  describe '#destroy', authenticated: true do
    let(:user)   { FactoryBot.create(:user) }
    let(:params) { { id: user.id } }
    let(:json)   { JSON.parse(subject.body, symbolize_names: true) }

    subject { post(:destroy, params: params) }

    context 'when successful' do
      it { is_expected.to have_http_status(:ok) }

      it 'destroys the user record' do
        expect { subject }.to change { User.count }.by(-1)
      end

      it_behaves_like 'a json response'
    end
  end
end
