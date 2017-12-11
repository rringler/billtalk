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

class CommentSerializer < ActiveModel::Serializer
  attributes :id,
    :commentable_id,
    :commentable_type,
    :text

  attribute :measure_start, if: :for_measure?
  attribute :measure_end,   if: :for_measure?

  belongs_to :user
  has_many   :comments

  def for_measure?
    @for_measure ||= object.commentable.is_a?(Measure)
  end
end
