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
    let(:election) { FactoryBot.create(:election, measure_count: 3) }
    let(:json)     { JSON.parse(serialize(election), symbolize_names: true) }

    it 'serializes the data correctly' do
      expect(json[:data]).to match(
        id:         election.id.to_s,
        type:       'elections',
        attributes: {
          date: election.date,
          name: election.name
        },
        relationships: {
          state:    a_kind_of(Hash),
          measures: a_kind_of(Hash)
        }
      )
    end
  end
end
