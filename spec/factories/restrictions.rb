require_relative '../../lib/models/restriction_group.rb'
require_relative '../../lib/models/restriction_type.rb'
require_relative '../../lib/models/restriction_type/minimum_item_quantity.rb'

FactoryBot.define do
  factory :restriction do
    restriction_group_id { create(:restriction_group).id }

    trait :miq do
      restriction_type_id do
        RestrictionType.find_or_create_by(
          attributes_for(:restriction_type, :miq)
        ).id
      end

      restriction_id do
        RestrictionType::MinimumItemQuantity.find_or_create_by(
          attributes_for(:minimum_item_quantity, :two_of_a)
        ).id
      end
    end

    trait :mov do
      restriction_type_id do
        RestrictionType.find_or_create_by(
          attributes_for(:restriction_type, :mov)
        ).id
      end

      restriction_id do
        RestrictionType::MinimumOrderValue.find_or_create_by(
          attributes_for(:minimum_order_value)
        ).id
      end
    end
  end
end
