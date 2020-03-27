require 'active_record'
require_relative '../reward_type.rb'

class RewardType::PercentOff < ActiveRecord::Base
  validates :percentage, presence: true,
    uniqueness: true, numericality: { less_than: 100 }

  def apply(order)
    reduced_total = order.total * (1 - (percentage / 100))
    order.update(total: reduced_total)
  end
end
