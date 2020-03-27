FactoryBot.define do
  factory :reward_type do
    trait :percent_off do
      name { "Percent Off" }
    end

    trait :value_off do
      name { "Value Off" }
    end
  end
end
