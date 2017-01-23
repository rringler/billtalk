# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'factories' do
    let(:factories) do
      [
        FactoryGirl.build(:user)
      ]
    end

    it 'has valid factories' do
      expect(factories).to all(be_valid)
    end
  end

  context 'validations' do
    subject { FactoryGirl.build(:user) }

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:email) }

    it { is_expected.to have_secure_password }
  end
end
