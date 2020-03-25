require_relative './item_order.rb'

class Checkout
  attr_accessor :order
  def initialize(currency = Currency.find_or_create_by(code: "GBP"))
    @order = Order.create(currency: currency)
  end

  def scan(item)
    @order.items << item
  end
end
