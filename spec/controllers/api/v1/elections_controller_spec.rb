require 'rails_helper'

RSpec.describe Api::V1::ElectionsController, type: :controller do
  describe '#create', authenticated: true do
    let(:election_attrs) { FactoryBot.attributes_for(:election) }
    let(:params)         { { election: election_attrs } }

    subject { post(:create, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'creates a new Election record' do
      expect { subject }.to change { Election.count }.by(1)
    end

    it_behaves_like 'a json response'
  end

  describe '#show', authenticated: false do
    let!(:election)    { FactoryBot.create(:election) }
    let(:params)       { { params: { id: election.id } } }
    let(:json)         { JSON.parse(subject.body) }
    let(:json_data_id) { json['data']['id']}

    subject { get(:show, params) }

    it { is_expected.to have_http_status(:ok) }

    it_behaves_like 'a json response'
  end

  describe '#update', authenticated: true do
    let!(:current_date) { Time.zone.now.change(usec: 0) }
    let!(:future_date)  { current_date + 1.day }
    let!(:election)     { FactoryBot.create(:election, date: current_date) }
    let(:params)        { { id: election.id, election: { date: future_date } } }

    subject { post(:update, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'updates the correct Election record' do
      expect { subject }.to change {
        election.reload.date
      }.from(current_date).to(future_date)
    end

    it_behaves_like 'a json response'
  end

  describe '#destroy', authenticated: true do
    let!(:election) { FactoryBot.create(:election) }
    let(:params)    { { id: election.id } }

    subject { post(:destroy, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'destroys the Election record' do
      expect { subject }.to change { Election.count }.by(-1)
    end

    it_behaves_like 'a json response'
  end
end
