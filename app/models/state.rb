# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class State < ApplicationRecord
  has_many :elections,
    inverse_of: :state

  validates :code,
    presence:   true,
    uniqueness: true
end
