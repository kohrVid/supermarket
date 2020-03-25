require_relative "../../lib/models/currency.rb"

FactoryBot.define do
  factory :item do
    trait :a do
      name { "A" }
      price { 50 }
      currency_id { create(:currency).id }
    end

    trait :b do
      name { "B" }
      price { 30 }
      currency_id { create(:currency).id }
    end
  end
end
