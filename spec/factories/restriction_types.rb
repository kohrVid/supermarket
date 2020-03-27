FactoryBot.define do
  factory :restriction_type do
    trait :mov do
      name { "Minimum Order Value" }
    end

    trait :miq do
      name { "Minimum Item Quantity" }
    end
  end
end
