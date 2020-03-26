require 'active_record'

class Restriction < ActiveRecord::Base
  belongs_to :group, class_name: "RestrictionGroup"
  belongs_to :type, class_name: "RestrictionType"

  validates :restriction_id, presence: true
  validates :restriction_group_id, presence: true
  validates :restriction_type_id, presence: true
end
