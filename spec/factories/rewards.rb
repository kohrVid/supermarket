require_relative '../../lib/models/reward_type.rb'
require_relative '../../lib/models/reward_type/percent_off.rb'
require_relative '../../lib/models/reward_type/value_off.rb'

FactoryBot.define do
  factory :reward do
    trait :percent_off do
      reward_type_id { create(:reward_type, :percent_off).id }
      reward_id do
        RewardType::PercentOff.find_or_create_by(
          attributes_for(:percent_off)
        ).id
      end
    end

    trait :value_off do
      reward_type_id { create(:reward_type, :value_off).id }
      reward_id do
        RewardType::ValueOff.find_or_create_by(attributes_for(:value_off)).id
      end
    end
  end
end
