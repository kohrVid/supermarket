require 'active_record'

class Order < ActiveRecord::Base
  belongs_to :currency
  has_many :item_orders
  has_many :items,
    after_add: :update_total!,
    after_remove: :update_total!,
    through: :item_orders
  validates :currency_id, presence: true

  private

  def update_total!(item=nil)
    update_subtotal!
    update(total: subtotal)
  end

  def update_subtotal!
    update(subtotal: items.map(&:price).reduce(0){ |sum, x| sum + x })
  end
end
