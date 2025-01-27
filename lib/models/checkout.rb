require 'money'
Dir[File.join(__dir__, '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'restriction_type', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'reward_type', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, '..', 'presenters', '*.rb')].each { |file| require file }

class Checkout
  attr_accessor :order

  def initialize(
    pricing_rules,
    order = nil,
    currency = Currency.find_or_create_by(code: "GBP")
  )
    @pricing_rules = pricing_rules
    @order = order || Order.create(currency: currency)
  end

  def scan(item)
    @order.items << item
    if @order.pricing_rules_applied
      @order.update(pricing_rules_applied: false)
    end
  end

  def remove(item)
    items = @order.items.each_with_index.select{ |i, idx| i == item }
    arr = @order.items.to_a
    arr.delete_at(items.last[1])
    @order.items = arr

    if @order.pricing_rules_applied
      @order.update(pricing_rules_applied: false)
    end
  end

  def total
    if !@order.pricing_rules_applied
      pricing_rules.each do |rule|
        new_total = @order.total.to_i - rule.discount_to_apply(@order)
        @order.update(total: new_total)
      end

      @order.update(pricing_rules_applied: true)
    end

    OrderPresenter.new(@order).total
  end

  def pricing_rules
    @pricing_rules.select{ |rule| rule.apply_last == false }.concat(
      @pricing_rules.select{ |rule| rule.apply_last == true }
    )
  end
end
