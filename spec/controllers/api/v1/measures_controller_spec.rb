require 'rails_helper'

RSpec.describe Api::V1::MeasuresController, type: :controller do
  describe '#create', authenticated: true do
    let(:election)      { FactoryBot.create(:election) }
    let(:measure_attrs) { FactoryBot.attributes_for(:measure).merge(election_id: election.id) }
    let(:params)        { { measure: measure_attrs } }

    subject { post(:create, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'creates a Measure record' do
      expect { subject }.to change { Measure.count }.by(1)
    end

    it_behaves_like 'a json response'
  end

  describe '#show', authenticated: false do
    let!(:measure)     { FactoryBot.create(:measure) }
    let(:params)       { { id: measure.id } }
    let(:json)         { JSON.parse(subject.body) }
    let(:json_data_id) { json['data']['id']}

    subject { get(:show, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it_behaves_like 'a json response'
  end

  describe '#update', authenticated: true do
    let!(:measure) { FactoryBot.create(:measure, :failed) }
    let(:params)   { { id: measure.id, measure: { result: true } } }

    subject { post(:update, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'updates the correct measure' do
      expect { subject }.to change {
        measure.reload.result
      }.from(false).to(true)
    end

    it_behaves_like 'a json response'
  end

  describe '#destroy', authenticated: true do
    let!(:measure) { FactoryBot.create(:measure, :failed) }
    let(:params)   { { id: measure.id } }

    subject { post(:destroy, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'destroys the Measure record' do
      expect { subject }.to change { Measure.count }.by(-1)
    end

    it_behaves_like 'a json response'
  end
end
