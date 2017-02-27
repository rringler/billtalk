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

class User < ApplicationRecord
  has_secure_password

  has_many :comments

  validates :email,
    presence:   true,
    uniqueness: true

  validates :password,
    length: { minimum: 6 },
    if:     :password

  validates_confirmation_of :password,
    if: :password

  validates :accepts_tos,
    inclusion: { in: [true] },
    on: :create

  attribute :accepts_tos, :boolean
  attribute :token,       :string

  after_create :generate_token

  private

  def generate_token
    self.token = Knock::AuthToken.new(payload: { sub: id }).token
  end
end
