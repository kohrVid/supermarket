require 'money'
Dir[File.join(__dir__, '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'restriction_type', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'reward_type', '*.rb')].each { |file| require file }

class Checkout
  attr_accessor :order
  def initialize(
    pricing_rules,
    order = nil,
    currency = Currency.find_or_create_by(code: "GBP")
  )
    @pricing_rules = pricing_rules
    @currency = currency
    @order = order || Order.create(currency: currency)
  end

  def scan(item)
    @order.items << item
    if @order.pricing_rules_applied
      @order.update(pricing_rules_applied: false)
    end
  end

  def total
    if !@order.pricing_rules_applied
      pricing_rules.each do |rule|
        new_total = @order.total.to_i - rule.order_deduction(@order)
        @order.update(total: new_total)
      end
      @order.update(pricing_rules_applied: true)
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
