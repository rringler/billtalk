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

FactoryBot.define do
  factory :election do
    state_id { State.random.id }
    date     { Date.today }
    name     { FFaker::Lorem.sentence }

    transient do
      measure_count 0
    end

    after(:build) do |election, evaluator|
      election.measures += FactoryBot.build_list(
        :measure,
        evaluator.measure_count,
        election: election
      )
    end
  end
end
