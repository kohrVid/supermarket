require_relative '../../lib/models/reward_type.rb'
require_relative '../../lib/models/reward_type/percent_off.rb'
require_relative '../../lib/models/reward_type/value_off.rb'

FactoryBot.define do
  factory :reward do
    trait :percent_off do
      reward_type_id { create(:reward_type, :percent_off).id }
      reward_id { create(:percent_off).id }
    end

    trait :value_off do
      reward_type_id { create(:reward_type, :value_off).id }
      reward_id { create(:value_off).id }
    end
  end
end
