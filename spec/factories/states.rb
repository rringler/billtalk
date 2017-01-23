# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :state do
    code 'CA'

    transient do
      election_count 0
    end

    after(:build) do |state, evaluator|
      state.elections += FactoryGirl.build_list(
        :election,
        evaluator.election_count,
        state: state
      )
    end
  end
end
