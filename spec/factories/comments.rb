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
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_user_id                              (user_id)
#

FactoryGirl.define do
  factory :comment do
    user
    text { FFaker::Lorem.paragraph }

    factory :measure_comment do
      association :commentable, factory: :measure

      measure_start { 0 }
      measure_end   { commentable.text.size - 1}
    end

    factory :comment_comment do
      association :commentable, factory: :measure_comment
    end
  end
end
