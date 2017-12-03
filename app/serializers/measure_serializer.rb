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

class MeasureSerializer < ActiveModel::Serializer
  attributes :id,
    :title,
    :description,
    :text,
    :result

  belongs_to :election
  has_many   :comments
end
