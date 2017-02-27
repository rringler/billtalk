require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  describe "attributes" do
    let(:user) { FactoryGirl.create(:user, comment_count: 3) }
    let(:json) { JSON.parse(serialize(user)) }

    it 'serializes the correct attributes' do
      expect(json['data']['attributes'].keys).to contain_exactly(
        'email',
        'token'
      )

      expect(json['data']['attributes']['email']).to eq(user.email)
    end

    it 'serializes the correct relationships' do
      expect(json['data']['relationships'].keys).to contain_exactly(
        'comments'
      )

      json_comments = json['data']['relationships']['comments']['data']

      expect(json_comments.size).to eq(3)
    end
  end
end
