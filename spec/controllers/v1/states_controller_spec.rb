require 'rails_helper'

RSpec.describe V1::StatesController, type: :controller do
  describe '#create' do
    let(:state_attrs) { { code: 'MX' } } # Non-existent state code
    let(:params)      { { params: { state: state_attrs } } }

    subject { post(:create, params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }

      it 'returns the serialized state' do
        expect { subject }.to change { State.count }.by(1)

        created_state = State.last
        created_attrs = created_state.attributes.with_indifferent_access

        expect(created_attrs).to include(state_attrs)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe '#show' do
    let(:state)        { State.random }
    let(:params)       { { params: { id: state.id } } }
    let(:json)         { JSON.parse(subject.body) }
    let(:json_data_id) { json['data']['id']}

    subject { get(:show, params) }

    it 'returns the serialized state' do
      expect(response).to have_http_status(:ok)

      expect(json_data_id).to eq(state.id.to_s)
    end
  end

  describe '#update' do
    let!(:state) { State.find_by(code: 'CA') }
    let(:params) { { params: { id: state.id, state: { code: 'MX' } } } }

    subject { post(:update, params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }

      it 'updates the correct measure' do
        expect { subject }.to change {
          state.reload.code
        }.from('CA').to('MX')
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe '#destroy' do
    let!(:state) { FactoryGirl.create(:state, code: 'MX') }
    let(:params) { { params: { id: state.id } } }

    subject { post(:destroy, params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }

      it 'destroys the state record' do
        expect { subject }.to change { State.count }.by(-1)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
