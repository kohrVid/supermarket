FactoryBot.define do
  factory :pricing_rule do
    trait :line_items do
      name { "2 items A for £90" }
    end

    trait :line_items_2 do
      name { "3 items B for £75" }
    end

    trait :basket do
      name { "10% off total basket cost for baskets worth over £200" }
      apply_last { true }
    end
  end
end
