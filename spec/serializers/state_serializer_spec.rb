# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#

require 'rails_helper'

RSpec.describe StateSerializer, type: :serializer do
  describe "attributes" do
    let(:state) { FactoryBot.create(:state, election_count: 3) }
    let(:json)  { JSON.parse(serialize(state)) }

    it 'serializes the correct attributes' do
      expect(json['data']['attributes'].keys).to contain_exactly(
        'code'
      )

      expect(json['data']['attributes']['code']).to eq(state.code)
    end

    it 'serializes the correct relationships' do
      expect(json['data']['relationships'].keys).to contain_exactly(
        'elections'
      )

      json_measures = json['data']['relationships']['elections']['data']

      expect(json_measures.size).to eq(3)
    end
  end
end
