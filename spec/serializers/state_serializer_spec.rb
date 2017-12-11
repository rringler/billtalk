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
  let(:state) { FactoryBot.create(:state, election_count: 3) }
  let(:json)  { JSON.parse(serialize(state), symbolize_names: true) }

  it 'serializes the data correctly' do
    expect(json[:data]).to match(
      id:         state.id.to_s,
      type:       'states',
      attributes: {
        code: state.code,
        name: state.name
      },
      relationships: {
        elections: a_kind_of(Hash)
      }
    )
  end
end
