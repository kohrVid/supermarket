require_relative '../../lib/models/reward_type/value_off.rb'

FactoryBot.define do
  factory :reward_type_value_off,
    aliases: [:value_off],
    class: RewardType::ValueOff do
      value { 500 }
  end
end
