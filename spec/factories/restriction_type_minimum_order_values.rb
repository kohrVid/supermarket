require_relative '../../lib/models/restriction_type/minimum_order_value.rb'

FactoryBot.define do
  factory :restriction_type_minimum_order_value,
    aliases: [:minimum_order_value],
    class: RestrictionType::MinimumOrderValue do
      value { 20000 }
  end
end
