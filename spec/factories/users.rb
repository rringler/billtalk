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
    sequence(:email)      { |n| "user_#{n.to_s.rjust(2, '0')}@example.com" }
    password              '123456'
    password_confirmation '123456'
  end
end
