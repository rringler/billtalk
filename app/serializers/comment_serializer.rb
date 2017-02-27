class CommentSerializer < ActiveModel::Serializer
  attributes :id,
    :commentable_id,
    :commentable_type,
    :text

  attribute :measure_start, if: :on_measure?
  attribute :measure_end,   if: :on_measure?

  belongs_to :user
  has_many   :comments

  def on_measure?
    @on_measure ||= object.commentable.is_a?(Measure)
  end
end
