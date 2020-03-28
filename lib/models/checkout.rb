require 'money'
require_relative './item_order.rb'

class Checkout
  attr_accessor :order
  def initialize(
    pricing_rules,
    currency = Currency.find_or_create_by(code: "GBP")
  )
    @pricing_rules = pricing_rules
    @currency = currency
    @order = Order.create(currency: currency)
  end

  def scan(item)
    @order.items << item
  end

  def total
    pricing_rules.each do |rule|
      rule.apply_reward(@order)
    end

    Money.new(
      @order.total,
      @currency.code
    ).format
  end

  def pricing_rules
    @pricing_rules.select{ |rule| rule.apply_last == false }.concat(
      @pricing_rules.select{ |rule| rule.apply_last == true }
    )
  end
end
