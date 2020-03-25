require_relative "../../lib/models/currency.rb"

FactoryBot.define do
  factory :order do
    subtotal { 50 }
    total { 50 }
    currency { create(:currency) }
  end
end
