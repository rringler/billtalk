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

RSpec.describe Measure, type: :model do
  context 'factories' do
    let(:factories) do
      [
        FactoryBot.build(:measure)
      ]
    end

    it 'has valid factories' do
      expect(factories).to all(be_valid)
    end
  end

  context 'validations' do
    subject { FactoryBot.build(:measure) }

    it { is_expected.to validate_presence_of(:election) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:text) }

    it { is_expected.to validate_uniqueness_of(:title) }
  end

  context 'associations' do
    describe ':election' do
      it { is_expected.to belong_to(:election) }
    end
  end
end
