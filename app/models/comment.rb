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

class Comment < ApplicationRecord
  belongs_to :user,
    required: true

  belongs_to :commentable,
    polymorphic: true,
    required:    true

  has_many :comments,
    as: :commentable

  store :meta,
    accessors: [
      :measure_start,
      :measure_end
    ]

  validates :text,
    presence: true

  validates :measure_start,
    presence: true,
    if:       -> { commentable.is_a?(Measure) }

  validates :measure_end,
    presence: true,
    if:       -> { commentable.is_a?(Measure) }
end
