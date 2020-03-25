require_relative "../../lib/models/currency.rb"

FactoryBot.define do
  factory :item do
    name { "A" }
    price { 50 }
    currency_id { create(:currency).id }
  end
end
