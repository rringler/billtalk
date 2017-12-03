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

RSpec.describe State, type: :model do
  context 'factories' do
    let(:factories) do
      [
        FactoryGirl.build(:state)
      ]
    end

    it 'has valid factories' do
      expect(factories).to all(be_valid)
    end
  end

  context 'validations' do
    subject { FactoryGirl.build(:state) }

    it { is_expected.to validate_presence_of(:code) }

    it { is_expected.to validate_uniqueness_of(:code) }
  end

  context 'associations' do
    describe ':elections' do
      it { is_expected.to have_many(:elections).inverse_of(:state) }
    end
  end
end
