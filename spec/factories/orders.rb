require_relative "../../lib/models/currency.rb"

FactoryBot.define do
  factory :order do
    subtotal { 5000 }
    total { 5000 }
    currency { create(:currency) }
  end
end
