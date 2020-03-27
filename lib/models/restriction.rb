require 'active_record'

class Restriction < ActiveRecord::Base
  belongs_to :group, foreign_key: :restriction_group_id,
    class_name: "RestrictionGroup"
  belongs_to :type, foreign_key: :restriction_type_id,
    class_name: "RestrictionType"

  validates :restriction_id, presence: true
  validates :restriction_group_id, presence: true
  validates :restriction_type_id, presence: true

  def body
    "RestrictionType::#{type.name.gsub(" ", "").camelcase}"
      .constantize.find(restriction_id)
  end
end
