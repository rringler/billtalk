require 'rails_helper'

RSpec.describe V1::ElectionsController, type: :controller do
  describe '#create' do
    let(:election_attrs) { FactoryGirl.attributes_for(:election) }
    let(:params)         { { election: election_attrs } }

    subject { post(:create, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }

      it 'returns the serialized election' do
        expect { subject }.to change { Election.count }.by(1)

        created_election = Election.last
        created_attrs   = created_election.attributes.with_indifferent_access

        expect(created_attrs).to include(election_attrs)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe '#show' do
    let!(:election)    { FactoryGirl.create(:election) }
    let(:params)       { { params: { id: election.id } } }
    let(:json)         { JSON.parse(subject.body) }
    let(:json_data_id) { json['data']['id']}

    subject { get(:show, params) }

    it 'returns the serialized election' do
      expect(response).to have_http_status(:ok)

      expect(json_data_id).to eq(election.id.to_s)
    end
  end

  describe '#update' do
    let!(:current_date) { Time.zone.now.change(usec: 0) }
    let!(:future_date)  { current_date + 1.day }
    let!(:election)     { FactoryGirl.create(:election, date: current_date) }
    let(:params)        { { id: election.id, election: { date: future_date } } }

    subject { post(:update, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token'
      it { is_expected.to have_http_status(:ok) }

      it 'updates the correct measure' do
        expect { subject }.to change {
          election.reload.date
        }.from(current_date).to(future_date)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe '#destroy' do
    let!(:election) { FactoryGirl.create(:election) }
    let(:params)    { { id: election.id } }

    subject { post(:destroy, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }

      it 'destroys the election record' do
        expect { subject }.to change { Election.count }.by(-1)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
