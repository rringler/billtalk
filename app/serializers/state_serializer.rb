# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#

class StateSerializer < ActiveModel::Serializer
  attributes :id,
    :code,
    :name

  has_many :elections
end
