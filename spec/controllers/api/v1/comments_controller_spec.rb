require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  describe '#create', authenticated: true do
    let(:measure) { FactoryBot.create(:measure) }

    let(:comment_attrs) do
      {
        text:             FFaker::Lorem.paragraph,
        commentable_id:   measure.id,
        commentable_type: measure.class.to_s,
        measure_start:    '0',
        measure_end:      '2'
      }
    end

    let(:params) { { comment: comment_attrs } }

    subject { post(:create, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'creates a new Comment record' do
      expect { subject }.to change { Comment.count }.by(1)
    end

    it_behaves_like 'a json response'
  end

  describe '#show', authenticated: false do
    let!(:comment)     { FactoryBot.create(:measure_comment) }
    let(:params)       { { id: comment.id } }
    let(:json)         { JSON.parse(subject.body) }
    let(:json_data_id) { json['data']['id']}

    subject { get(:show, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it_behaves_like 'a json response'
  end

  describe '#update', authenticated: true do
    let!(:comment) { FactoryBot.create(:measure_comment) }
    let(:params)   { { id: comment.id, comment: { text: 'updated' } } }
    let(:user)     { comment.user }

    subject { post(:update, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'updates the correct Comment record' do
      expect { subject }.to change {
        comment.reload.text
      }.to('updated')
    end

    it_behaves_like 'a json response'
  end

  describe '#destroy', authenticated: true do
    let!(:comment) { FactoryBot.create(:measure_comment) }
    let(:params)   { { id: comment.id } }
    let(:user)     { comment.user }

    subject { post(:destroy, params: params) }

    it { is_expected.to have_http_status(:ok) }

    it 'destroys the comment record' do
      expect { subject }.to change { Comment.count }.by(-1)
    end

    it_behaves_like 'a json response'
  end
end
