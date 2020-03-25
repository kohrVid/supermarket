require_relative "../../lib/models/currency.rb"

FactoryBot.define do
  factory :item do
    trait :a do
      name { "A" }
      price { 5000 }
      currency_id { create(:currency).id }
    end

    trait :b do
      name { "B" }
      price { 3000 }
      currency_id { create(:currency).id }
    end
  end
end
