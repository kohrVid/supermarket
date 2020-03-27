require 'active_record'
require_relative '../reward_type.rb'

class RewardType::PercentOff < ActiveRecord::Base
  validates :percentage, presence: true, uniqueness: true
end
