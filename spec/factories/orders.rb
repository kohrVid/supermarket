require_relative "../../lib/models/currency.rb"

FactoryBot.define do
  factory :order do
    subtotal { 0 }
    total { 0 }
    currency { create(:currency) }
  end
end
