require 'active_record'

class Order < ActiveRecord::Base
  belongs_to :currency
  has_many :item_orders
  has_many :items, through: :item_orders
  validates :currency_id, presence: true

  def update_total!
    update_subtotal!
    update(total: subtotal)
  end

  def update_subtotal!
    update(subtotal: items.map(&:price).reduce(:+))
  end
end
