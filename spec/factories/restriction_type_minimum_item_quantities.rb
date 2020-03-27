require_relative '../../lib/models/restriction_type/minimum_item_quantity.rb'

FactoryBot.define do
  factory :restriction_type_minimum_item_quantity,
    aliases: [:minimum_item_quantity],
    class: RestrictionType::MinimumItemQuantity do
      trait :two_of_a do
        item_id do
          Item.find_or_create_by(attributes_for(:item, :a)).id
        end
        quantity { 2 }
      end
  end
end
