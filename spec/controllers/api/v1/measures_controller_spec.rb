require 'rails_helper'

RSpec.describe Api::V1::MeasuresController, type: :controller do
  describe '#create' do
    let(:election)      { FactoryGirl.create(:election) }
    let(:measure_attrs) { FactoryGirl.attributes_for(:measure).merge(election_id: election.id) }
    let(:params)        { { measure: measure_attrs } }

    subject { post(:create, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }

      it 'returns the serialized measure' do
        expect { subject }.to change { Measure.count }.by(1)

        created_measure = Measure.last
        created_attrs   = created_measure.attributes.with_indifferent_access

        expect(created_attrs).to include(measure_attrs)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe '#show' do
    let!(:measure)     { FactoryGirl.create(:measure) }
    let(:params)       { { id: measure.id } }
    let(:json)         { JSON.parse(subject.body) }
    let(:json_data_id) { json['data']['id']}

    subject { get(:show, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'returns the serialized measure' do
      expect(response).to have_http_status(:ok)

      expect(json_data_id).to eq(measure.id.to_s)
    end
  end

  describe '#update' do
    let!(:measure) { FactoryGirl.create(:measure, :failed) }
    let(:params)   { { id: measure.id, measure: { result: true } } }

    subject { post(:update, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }

      it 'updates the correct measure' do
        expect { subject }.to change {
          measure.reload.result
        }.from(false).to(true)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe '#destroy' do
    let!(:measure) { FactoryGirl.create(:measure, :failed) }
    let(:params)   { { id: measure.id } }

    subject { post(:destroy, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }

      it 'destroys the measure record' do
        expect { subject }.to change { Measure.count }.by(-1)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
