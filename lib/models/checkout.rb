require 'money'
require_relative './item_order.rb'

class Checkout
  attr_accessor :order
  def initialize(currency = Currency.find_or_create_by(code: "GBP"))
    @currency = currency
    @order = Order.create(currency: currency)
  end

  def scan(item)
    @order.items << item
  end

  def total
    Money.new(
      @order.total,
      @currency.code
    ).format
  end
end
