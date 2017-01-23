# == Schema Information
#
# Table name: elections
#
#  id         :integer          not null, primary key
#  state_id   :integer          not null
#  date       :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_elections_on_date      (date)
#  index_elections_on_state_id  (state_id)
#

FactoryGirl.define do
  factory :election do
    state_id { State.random.id }
    date     { Date.today }

    transient do
      measure_count 0
    end

    after(:build) do |election, evaluator|
      election.measures += FactoryGirl.build_list(
        :measure,
        evaluator.measure_count,
        election: election
      )
    end
  end
end
