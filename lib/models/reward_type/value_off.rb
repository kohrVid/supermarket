require 'active_record'
require_relative '../reward_type.rb'

class RewardType::ValueOff < ActiveRecord::Base
  validates :value, presence: true, uniqueness: true

  def calculate_deduction(original_amount, number_of_deductions)
    new_amount = value * number_of_deductions
    original_amount > new_amount ? new_amount : 0
  end
end
