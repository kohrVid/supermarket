require 'active_record'
require_relative '../restriction_type.rb'

class RestrictionType::MinimumItemQuantity < ActiveRecord::Base
  belongs_to :item
  validates :item_id, presence: true
  validates :quantity, numericality: { greater_than: 0 },
    uniqueness: { scope: :item_id }

  def check(order)
    order.items.select{ |i| item == i }.length >= quantity
  end
end
