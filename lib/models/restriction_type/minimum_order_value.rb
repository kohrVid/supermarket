require 'active_record'
require_relative '../restriction_type.rb'

class RestrictionType::MinimumOrderValue < ActiveRecord::Base
  validates :value, presence: true,
    numericality: { greater_than: 0 }, uniqueness: true

  def check(order)
    restriction_met = (order.subtotal >= value)
    number_of_matches = (order.subtotal / value)

    [restriction_met, number_of_matches]
  end
end
