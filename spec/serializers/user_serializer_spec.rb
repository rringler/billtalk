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
    let(:user) { FactoryBot.create(:user, comment_count: 3) }
    let(:json) { JSON.parse(serialize(user), symbolize_names: true) }

    it 'serializes the data correctly' do
      expect(json[:data]).to match(
        id:         user.id.to_s,
        type:       'users',
        attributes: {
          email: user.email,
          token: user.token
        },
        relationships: {
          comments: a_kind_of(Hash)
        }
      )
    end
  end
end
