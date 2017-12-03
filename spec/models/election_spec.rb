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

RSpec.describe Election, type: :model do
  context 'factories' do
    let(:factories) do
      [
        FactoryGirl.build(:election)
      ]
    end

    it 'has valid factories' do
      expect(factories).to all(be_valid)
    end
  end

  context 'validations' do
    subject { FactoryGirl.build(:election) }

    it { is_expected.to validate_presence_of(:date) }
  end

  context 'associations' do
    describe ':state' do
      it { is_expected.to belong_to(:state) }
    end

    describe ':measures' do
      it { is_expected.to have_many(:measures).inverse_of(:election) }
    end
  end
end
