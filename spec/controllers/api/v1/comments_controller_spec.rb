require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  describe '#create' do
    let(:measure)       { FactoryBot.create(:measure) }
    let(:comment_attrs) do
      {
        text:             FFaker::Lorem.paragraph,
        commentable_id:   measure.id,
        commentable_type: measure.class.to_s,
        measure_start:    '0',
        measure_end:      '2'
      }
    end

    let(:params)         { { comment: comment_attrs } }

    subject { post(:create, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token'

      it { is_expected.to have_http_status(:ok) }
      it { expect { subject }.to change { Comment.count }.by(1) }

      it 'returns the serialized comment' do
        json                = JSON.parse(subject.body)
        json_attributes     = json['data']['attributes']
        expected_attributes = {
          'text'             => comment_attrs[:text],
          'commentable-id'   => comment_attrs[:commentable_id],
          'commentable-type' => comment_attrs[:commentable_type],
          'measure-start'    => comment_attrs[:measure_start],
          'measure-end'      => comment_attrs[:measure_end]
        }

        expect(json_attributes).to include(expected_attributes)
      end

      # it do
      #   created_comment = Comment.last
      #   created_attrs   = created_comment.attributes.with_indifferent_access

      #   expect(created_attrs).to include(comment_attrs)
      # end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe '#show' do
    let!(:comment)     { FactoryBot.create(:measure_comment) }
    let(:params)       { { id: comment.id } }
    let(:json)         { JSON.parse(subject.body) }
    let(:json_data_id) { json['data']['id']}

    subject { get(:show, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'returns the serialized comment' do
      expect(response).to have_http_status(:ok)

      expect(json_data_id).to eq(comment.id.to_s)
    end
  end

  describe '#update' do
    let!(:comment) { FactoryBot.create(:measure_comment) }
    let(:params)   { { id: comment.id, comment: { text: 'updated' } } }

    subject { post(:update, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token' do
        let(:user) { comment.user }
      end

      it { is_expected.to have_http_status(:ok) }

      it 'updates the correct comment' do
        expect { subject }.to change {
          comment.reload.text
        }.to('updated')
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe '#destroy' do
    let!(:comment) { FactoryBot.create(:measure_comment) }
    let(:params)   { { id: comment.id } }

    subject { post(:destroy, params: params) }

    context 'when authenticated' do
      include_context 'with authentication token' do
        let(:user) { comment.user }
      end

      it { is_expected.to have_http_status(:ok) }

      it 'destroys the comment record' do
        expect { subject }.to change { Comment.count }.by(-1)
      end
    end

    context 'when not authenticated' do
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
