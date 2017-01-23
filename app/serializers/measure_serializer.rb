class MeasureSerializer < ActiveModel::Serializer
  attributes :id,
    :title,
    :description,
    :text,
    :result

  belongs_to :election_id
end
