require 'active_record'
require 'money'

class Order < ActiveRecord::Base
  belongs_to :currency
  has_many :item_orders
  has_many :items, through: :item_orders
  validates :currency_id, presence: true

  def subtotal
    Money.new(
      items.map(&:price).reduce(:+),
      currency.code
    )
  end
end
