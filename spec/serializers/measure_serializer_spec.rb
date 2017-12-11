# == Schema Information
#
# Table name: measures
#
#  id          :integer          not null, primary key
#  election_id :integer          not null
#  title       :string           not null
#  description :string           not null
#  text        :text             not null
#  result      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe MeasureSerializer, type: :serializer do
  describe "attributes" do
    let(:measure) { FactoryBot.create(:measure) }
    let(:json)    { JSON.parse(serialize(measure), symbolize_names: true) }

    it 'serializes the data correctly' do
      expect(json[:data]).to match(
        id:         measure.id.to_s,
        type:       'measures',
        attributes: {
          title:       measure.title,
          description: measure.description,
          text:        measure.text,
          result:      measure.result
        },
        relationships: {
          election: a_kind_of(Hash),
          comments: a_kind_of(Hash)
        }
      )
    end
  end
end
