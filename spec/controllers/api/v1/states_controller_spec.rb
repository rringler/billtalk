require 'rails_helper'

RSpec.describe Api::V1::StatesController, type: :controller do
  describe '#index', authenticated: false do
    let(:json)       { JSON.parse(subject.body, symbolize_names: true) }
    let(:json_data)  { json[:data] }
    let(:json_attrs) { json_data.map { |json| json[:attributes] } }

    subject { get(:index) }

    it { is_expected.to have_http_status(:ok) }

    it 'returns the serialized states' do
      expect(json_attrs).to all(
        include(
          code: be_a(String),
          name: be_a(String)
        )
      )
    end
  end

  describe '#create', authenticated: true do
    let(:state_attrs) { { code: 'PT', name: 'Petoria' } }
    let(:params)      { { params: { state: state_attrs } } }

    subject { post(:create, params) }

    context 'when successful' do
      it { is_expected.to have_http_status(:ok) }

      it 'returns the serialized state' do
        expect { subject }.to change { State.count }.by(1)

        created_state = State.find!(code: state_attrs[:code])
        created_attrs = created_state.attributes.with_indifferent_access

        expect(created_attrs).to include(state_attrs)
      end
    end
  end

  describe '#show', authenticated: false do
    let(:state)        { State.random }
    let!(:elections)   { FactoryGirl.create_list(:election, 2, state: state) }
    let(:params)       { { params: { id: state.id } } }
    let(:json)         { JSON.parse(subject.body, symbolize_names: true) }
    let(:json_data_id) { json.dig(:data, :id) }

    subject { get(:show, params) }

    it { is_expected.to have_http_status(:ok) }

    it 'returns the serialized state' do
      expect(json_data_id).to eq(state.id.to_s)
    end
  end

  describe '#update', authenticated: true do
    let!(:state) { State.find_by(code: 'CA') }
    let(:params) { { params: { id: state.id, state: { code: 'PT' } } } }

    subject { post(:update, params) }

    context 'when successful' do
      it { is_expected.to have_http_status(:ok) }

      it 'updates the correct measure' do
        expect { subject }.to change {
          state.reload.code
        }.from('CA').to('PT')
      end
    end
  end

  describe '#destroy', authenticated: true do
    let!(:state) { FactoryGirl.create(:state, code: 'PT') }
    let(:params) { { params: { id: state.id } } }

    subject { post(:destroy, params) }

    context 'when successful' do
      it { is_expected.to have_http_status(:ok) }

      it 'destroys the state record' do
        expect { subject }.to change { State.count }.by(-1)
      end
    end
  end
end
