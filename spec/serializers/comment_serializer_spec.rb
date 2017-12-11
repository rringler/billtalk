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

require 'rails_helper'

RSpec.describe CommentSerializer, type: :serializer do
  let(:json) { JSON.parse(serialize(comment), symbolize_names: true) }

  context 'for comments on measures' do
    let(:comment) { FactoryBot.create(:measure_comment) }

    it 'serializes the data correctly' do
      expect(json[:data]).to match(
        id:         comment.id.to_s,
        type:       'comments',
        attributes: {
          text:               comment.text,
          'commentable-id':   comment.commentable_id,
          'commentable-type': comment.commentable_type,
          'measure-start':    comment.measure_start,
          'measure-end':      comment.measure_end
        },
        relationships: {
          user:     a_kind_of(Hash),
          comments: a_kind_of(Hash)
        }
      )
    end
  end

  context 'for comments on comments' do
    let(:comment) { FactoryBot.create(:comment_comment) }

    it 'serializes the data correctly' do
      expect(json[:data]).to match(
        id:         comment.id.to_s,
        type:       'comments',
        attributes: {
          text:               comment.text,
          'commentable-id':   comment.commentable_id,
          'commentable-type': comment.commentable_type
        },
        relationships: {
          user:     a_kind_of(Hash),
          comments: a_kind_of(Hash)
        }
      )
    end
  end
end
