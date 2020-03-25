FactoryBot.define do
  factory :currency do
    trait :gbp do
      code { "GBP" }
    end

    trait :eur do
      code { "EUR" }
    end
  end
end
