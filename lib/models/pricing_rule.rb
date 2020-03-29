require 'active_record'
require_relative './reward.rb'

class PricingRule < ActiveRecord::Base
  has_one :restriction_group
  has_one :reward
  has_many :restrictions, through: :restriction_group

  validates :name, presence: true, uniqueness: true

  def order_deduction(order)
    amount = 0

    check_all_restrictions = restrictions.map do |restriction|
      restriction.check(order)
    end

    if check_all_restrictions.map(&:first).exclude?(false) && reward.present?
      number_of_deductions = check_all_restrictions.map(&:second).reduce(:+)

      amount += reward.body.calculate_deduction(
        order.total, number_of_deductions
      )
    end

    amount
  end

  def restrictions
    Array(restriction_group).flat_map do |group|
      group.restrictions.map(&:body)
    end
  end
end
