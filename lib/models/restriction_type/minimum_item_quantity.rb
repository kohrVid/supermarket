require 'active_record'
require_relative '../item_order.rb'
require_relative '../restriction_type.rb'

class RestrictionType::MinimumItemQuantity < ActiveRecord::Base
  belongs_to :item

  validates :item_id, presence: true
  validates :quantity, numericality: { greater_than: 0 },
    uniqueness: { scope: :item_id }

  def check(order)
    list_item_quantity = order.items.select { |i| item == i }.length
    restriction_met = (list_item_quantity >=  quantity)
    number_of_matches = (list_item_quantity / quantity)

    [restriction_met, number_of_matches]
  end
end
