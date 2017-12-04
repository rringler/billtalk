# == Schema Information
#
# Table name: elections
#
#  id         :integer          not null, primary key
#  state_id   :integer          not null
#  date       :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#

require 'rails_helper'

RSpec.describe ElectionSerializer, type: :serializer do
  describe "attributes" do
    let(:election) do
      FactoryBot.create(:election, measure_count: 3)
    end

    let(:json) { JSON.parse(serialize(election)) }

    it 'serializes the correct attributes' do
      expect(json['data']['attributes'].keys).to contain_exactly(
        'date'
      )

      expect(json['data']['attributes']['date']).to  eq(election.date.iso8601(3))
    end

    it 'serializes the correct relationships' do
      expect(json['data']['relationships'].keys).to contain_exactly(
        'state',
        'measures'
      )

      json_state        = json['data']['relationships']['state']['data']
      json_state_id     = json_state['id']
      election_state_id = election.state.id.to_s

      expect(json_state_id).to eq(election_state_id)

      json_measures        = json['data']['relationships']['measures']['data']
      json_measure_ids     = json_measures.map { |m| m['id'] }
      election_measure_ids = election.measures.map { |m| m.id.to_s }

      expect(json_measure_ids).to contain_exactly(*election_measure_ids)
    end
  end
end
