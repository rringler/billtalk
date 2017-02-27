class UserSerializer < ActiveModel::Serializer
  attributes :id,
    :email

  attribute :token,
    if: :token?

  has_many :comments

  def token?
    object.token.present?
  end
end
