class ElectionSerializer < ActiveModel::Serializer
  attributes :id,
    :date

  belongs_to :state

  has_many :measures
end
