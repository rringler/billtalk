require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe '#create' do
    let(:user_attrs) { FactoryGirl.attributes_for(:user) }
    let(:params)     { { user: user_attrs } }

    subject { post(:create, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'returns the new serialized user' do
      expect { subject }.to change { User.count }.by(1)

      created_user  = User.last
      created_attrs = created_user.attributes.with_indifferent_access

      expect(created_attrs).to include(user_attrs.slice(:email))
    end
  end

  describe '#show' do
    let(:user)         { FactoryGirl.create(:user) }
    let(:params)       { { id: user.id } }
    let(:json)         { JSON.parse(subject.body) }
    let(:json_data_id) { json['data']['id'] }

    subject { get(:show, params: params) }

    it 'returns the serialized state' do
      expect(response).to have_http_status(:ok)

      expect(json_data_id).to eq(user.id.to_s)
    end
  end

  describe '#update' do
    let(:user)          { FactoryGirl.create(:user) }
    let(:current_email) { user.email }
    let(:new_email)     { "new_#{current_email}" }
    let(:params)        { { id: user.id, user: { email: new_email } } }

    subject { post(:update, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }

      it 'updates the correct measure' do
        expect { subject }.to change {
          user.reload.email
        }.from(current_email).to(new_email)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe '#destroy' do
    let(:user)   { FactoryGirl.create(:user) }
    let(:params) { { id: user.id } }

    subject { post(:destroy, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }

      it 'destroys the user record' do
        expect { subject }.to change { User.count }.by(-1)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
