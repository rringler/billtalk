# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  commentable_type :string           not null
#  commentable_id   :integer          not null
#  text             :text             not null
#  meta             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'factories' do
    let(:factories) do
      [
        FactoryGirl.build(:measure_comment),
        FactoryGirl.build(:comment_comment)
      ]
    end

    it 'has valid factories' do
      expect(factories).to all(be_valid)
    end
  end

  context 'validations' do
    subject { FactoryGirl.build(:measure_comment) }

    it { is_expected.to validate_presence_of(:text) }
  end

  context 'associations' do
    describe ':user' do
      it { is_expected.to belong_to(:user) }
    end

    describe ':commentable' do
      it { is_expected.to belong_to(:commentable) }
    end
  end
end
