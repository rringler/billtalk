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
    let(:measure) { FactoryGirl.create(:measure) }
    let(:json)    { JSON.parse(serialize(measure)) }

    it 'serializes the correct attributes' do
      expect(json['data']['attributes'].keys).to contain_exactly(
        'title',
        'description',
        'text',
        'result'
      )

      expect(json['data']['attributes']['title']).to       eq(measure.title)
      expect(json['data']['attributes']['description']).to eq(measure.description)
      expect(json['data']['attributes']['text']).to        eq(measure.text)
      expect(json['data']['attributes']['result']).to      eq(measure.result)
    end
  end
end
