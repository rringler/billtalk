# == Schema Information
#
# Table name: elections
#
#  id         :integer          not null, primary key
#  state_id   :integer          not null
#  date       :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_elections_on_date      (date)
#  index_elections_on_state_id  (state_id)
#

class Election < ApplicationRecord
  belongs_to :state,
    required: true

  has_many :measures,
    inverse_of: :election

  validates :date,
    presence: true
end
