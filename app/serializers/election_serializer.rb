# == Schema Information
#
# Table name: elections
#
#  id         :integer          not null, primary key
#  state_id   :integer          not null
#  date       :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#

class ElectionSerializer < ActiveModel::Serializer
  attributes :id,
    :date,
    :name

  belongs_to :state
  has_many   :measures
end
