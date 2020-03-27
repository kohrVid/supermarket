require_relative '../../lib/models/reward_type/percent_off.rb'

FactoryBot.define do
  factory :reward_type_percent_off,
    aliases: [:percent_off],
    class: RewardType::PercentOff do
      percentage { 10.0 }
  end
end
