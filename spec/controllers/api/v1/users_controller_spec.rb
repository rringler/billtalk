require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe '#create' do
    let(:user_attrs)      { FactoryGirl.attributes_for(:user) }
    let(:params)          { { user: user_attrs } }
    let(:json)            { JSON.parse(response.body) }
    let(:json_data_attrs) { json['data']['attributes'] }

    subject { post(:create, params: params) }

    it 'returns a successful status code' do
      is_expected.to have_http_status(:ok)
    end

    it 'creates a new user with the correct attributes' do
      expect { subject }.to change { User.count }.by(1)

      created_user  = User.last
      created_attrs = created_user.attributes.with_indifferent_access

      expect(created_attrs).to include(user_attrs.slice(:email))
    end

    it 'returns the serialized user' do
      Timecop.freeze do
        subject

        user       = User.last
        user_attrs = {
          'email' => user.email,
          'token' => user.send(:generate_token)
        }

        expect(json_data_attrs).to eq(user_attrs)
      end
    end
  end

  describe '#show' do
    let(:user)       { FactoryGirl.create(:user) }
    let(:params)     { { id: user.id } }
    let(:json)       { JSON.parse(subject.body) }
    let(:json_id)    { json['data']['id'] }
    let(:json_attrs) { json['data']['attributes'] }

    subject { get(:show, params: params) }

    it 'returns the serialized user' do
      expect(response).to have_http_status(:ok)

      expect(json_id).to    eq(user.id.to_s)
      expect(json_attrs).to eq('email' => user.email)
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
