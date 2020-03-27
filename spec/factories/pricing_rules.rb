FactoryBot.define do
  factory :pricing_rule do
    trait :line_items do
      name { "2 items A for £90" }
    end

    trait :basket do
      name { "10% off total basket cost for baskets worth over £200" }
      apply_last { true }
    end
  end
end
