require 'active_record'
require_relative './pricing_rule_order.rb'
require_relative './reward.rb'

class PricingRule < ActiveRecord::Base
  has_one :restriction_group
  has_one :reward
  has_many :pricing_rule_orders
  has_many :discounted_orders,
    class_name: "Order",
    through: :pricing_rule_orders,
    source: :order
  has_many :restrictions, through: :restriction_group

  validates :name, presence: true, uniqueness: true

  def discount_to_apply(order)
    amount = 0

    check_all_restrictions = restrictions.map do |restriction|
      restriction.check(order)
    end

    if check_all_restrictions.map(&:first).exclude?(false) && reward.present?
      number_of_deductions = check_all_restrictions.map(&:second).reduce(:+)

      amount += reward.body.calculate_deduction(
        order.total, number_of_deductions
      )

      # Note, this is probably not as efficient as `self.discounted_orders ||= [order]`
      # but this seems easier to follow and it's unclear that optimisation is
      # necessary at this stage.
      discounted_orders << order unless discounted_orders.include?(order)
    else
      discounted_orders.delete(order)
    end

    amount
  end

  def restrictions
    Array(restriction_group).flat_map do |group|
      group.restrictions.map(&:body)
    end
  end
end
