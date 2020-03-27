require 'active_record'
require_relative '../reward_type.rb'

class RewardType::ValueOff < ActiveRecord::Base
  validates :value, presence: true, uniqueness: true
end
