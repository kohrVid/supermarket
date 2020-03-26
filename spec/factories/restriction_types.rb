FactoryBot.define do
  factory :restriction_type do
    trait :mov do
      type { "Minimum Order Value" }
    end

    trait :miq do
      type { "Minimum Item Quantity" }
    end
  end
end
