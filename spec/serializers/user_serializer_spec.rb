# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

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
