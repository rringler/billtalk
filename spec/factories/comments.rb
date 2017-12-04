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

FactoryBot.define do
  factory :comment do
    user
    text { FFaker::Lorem.paragraph }

    factory :measure_comment do
      association :commentable, factory: :measure

      measure_start { 0 }
      measure_end   { commentable.text.split(' ').size - 1 }
    end

    factory :comment_comment do
      association :commentable, factory: :measure_comment
    end
  end
end
