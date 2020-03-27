require 'active_record'

class Reward < ActiveRecord::Base
  belongs_to :type, class_name: "RewardType"

  validates :reward_id, presence: true
  validates :reward_type_id, presence: true
end
