class StateSerializer < ActiveModel::Serializer
  attributes :id,
    :code

  has_many :elections
end
