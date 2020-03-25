require_relative "../../lib/models/currency.rb"

FactoryBot.define do
  factory :item do
    trait :a do
      name { "A" }
      price { 5000 }
      currency_id do
        Currency.find_or_create_by(attributes_for(:currency)).id
      end
    end

    trait :b do
      name { "B" }
      price { 3000 }
      currency_id do
        Currency.find_or_create_by(attributes_for(:currency)).id
      end
    end

    trait :c do
      name { "C" }
      price { 2000 }
      currency_id { create(:currency, code: "EUR").id }
    end
  end
end
