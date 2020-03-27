require 'active_record'
require_relative '../reward_type.rb'

class RewardType::ValueOff < ActiveRecord::Base
  validates :value, presence: true, uniqueness: true

  def apply(order)
    reduced_total = order.total - value
    order.update(total: reduced_total)
  end
end
