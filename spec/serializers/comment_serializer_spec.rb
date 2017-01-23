require 'rails_helper'

RSpec.describe CommentSerializer, type: :serializer do
  describe "attributes" do
    context 'for comments on measures' do
      let(:comment) { FactoryGirl.create(:measure_comment) }
      let(:json)    { JSON.parse(serialize(comment)) }

      it 'serializes the correct attributes' do
        expect(json['data']['attributes'].keys).to contain_exactly(
          'text',
          'commentable-id',
          'commentable-type',
          'measure-start',
          'measure-end'
        )

        expect(json['data']['attributes']['text']).to             eq(comment.text)
        expect(json['data']['attributes']['commentable-id']).to   eq(comment.commentable_id)
        expect(json['data']['attributes']['commentable-type']).to eq(comment.commentable_type)
        expect(json['data']['attributes']['measure-start']).to    eq(comment.measure_start)
        expect(json['data']['attributes']['measure-end']).to      eq(comment.measure_end)
      end
    end

    context 'for comments on comments' do
      let(:comment) { FactoryGirl.create(:comment_comment) }
      let(:json)    { JSON.parse(serialize(comment)) }

      it 'serializes the correct attributes' do
        expect(json['data']['attributes'].keys).to contain_exactly(
          'text',
          'commentable-id',
          'commentable-type'
        )

        expect(json['data']['attributes']['text']).to             eq(comment.text)
        expect(json['data']['attributes']['commentable-id']).to   eq(comment.commentable_id)
        expect(json['data']['attributes']['commentable-type']).to eq(comment.commentable_type)
      end
    end
  end
end
