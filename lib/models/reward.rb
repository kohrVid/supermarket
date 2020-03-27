require 'active_record'
require_relative './pricing_rule.rb'

class Reward < ActiveRecord::Base
  belongs_to :pricing_rule
  belongs_to :type, foreign_key: :reward_type_id, class_name: "RewardType"

  validates :pricing_rule_id, presence: true
  validates :reward_id, presence: true
  validates :reward_type_id, presence: true

  def body
    "RewardType::#{type.name.gsub(" ", "").camelcase}"
      .constantize.find(reward_id)
  end
end
