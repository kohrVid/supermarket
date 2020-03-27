require 'active_record'
require_relative '../restriction_type.rb'

class RestrictionType::MinimumOrderValue < ActiveRecord::Base
  validates :value, presence: true,
    numericality: { greater_than: 0 }, uniqueness: true

  def check(order)
    order.subtotal >= value
  end
end
