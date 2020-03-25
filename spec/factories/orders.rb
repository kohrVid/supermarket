require_relative "../../lib/models/currency.rb"

FactoryBot.define do
  factory :order do
    subtotal { 0 }
    total { 0 }
    currency_id do
      Currency.find_or_create_by(attributes_for(:currency, :gbp)).id
    end
  end
end
