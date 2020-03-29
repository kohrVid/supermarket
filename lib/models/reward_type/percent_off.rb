require 'active_record'
require_relative '../reward_type.rb'

class RewardType::PercentOff < ActiveRecord::Base
  validates :percentage, presence: true,
    uniqueness: true, numericality: { less_than: 100 }

  def calculate_deduction(original_amount, number_of_deductions=nil)
    original_amount * (percentage / 100)
  end
end
