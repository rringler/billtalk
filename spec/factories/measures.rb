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
# Indexes
#
#  index_measures_on_election_id  (election_id)
#

FactoryGirl.define do
  factory :measure do
    election

    sequence(:title) { |n| "Proposition #{n.to_s.rjust(2, '0')}" }
    description      { FFaker::Lorem.sentence }
    text             { FFaker::Lorem.paragraph }

    trait(:passed) { result true  }
    trait(:failed) { result false }
  end
end
