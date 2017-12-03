# == Schema Information
#
# Table name: measures
#
#  id          :integer          not null, primary key
#  election_id :integer          not null
#  title       :string           not null
#  description :string           not null
#  text        :text             not null
#  result      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Measure < ApplicationRecord
  belongs_to :election,
    required: true

  has_many :comments,
    as: :commentable

  validates :election,
    presence: true

  validates :title,
    presence:   true,
    uniqueness: true

  validates :description,
    presence: true

  validates :text,
    presence: true
end
