require 'active_record'
require_relative './pricing_rule.rb'

class Order < ActiveRecord::Base
  belongs_to :currency
  has_many :item_orders
  has_many :items,
    before_add: :validate_item_currency,
    after_add: :update_total!,
    after_remove: :update_total!,
    through: :item_orders
  has_many :pricing_rule_orders
  has_many :applied_discounts,
    class_name: "PricingRule",
    through: :pricing_rule_orders,
    source: :pricing_rule

  validates :currency_id, presence: true

  private

  def validate_item_currency(item)
    raise ActiveRecord::RecordNotSaved unless item.currency == currency
  end

  def update_total!(item=nil)
    update_subtotal!
    update(total: subtotal)
  end

  def update_subtotal!
    update(subtotal: items.map(&:price).reduce(0){ |sum, x| sum + x })
  end
end
