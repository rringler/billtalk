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

FactoryGirl.define do
  factory :user do
    accepts_tos           true
    sequence(:email)      { |n| "user_#{n.to_s.rjust(2, '0')}@example.com" }
    password              '123456'
    password_confirmation '123456'

    transient do
      comment_count 0
    end

    after(:build) do |user, evaluator|
      user.comments += FactoryGirl.build_list(
        :measure_comment,
        evaluator.comment_count,
        user: user
      )
    end
  end
end
