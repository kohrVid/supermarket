require_relative '../../lib/models/restriction_group.rb'
require_relative '../../lib/models/restriction_type.rb'
require_relative '../../lib/models/restriction_type/minimum_item_quantity.rb'

FactoryBot.define do
  factory :restriction do
    restriction_group_id { create(:restriction_group).id }
    restriction_type_id { create(:restriction_type, :miq).id }

    trait :miq do
      restriction_id { create(:minimum_item_quantity, :two_of_a).id }
    end
  end
end
