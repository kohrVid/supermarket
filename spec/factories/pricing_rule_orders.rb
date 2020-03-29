require_relative "../../lib/models/pricing_rule.rb"
require_relative "../../lib/models/order.rb"

FactoryBot.define do
  factory :pricing_rule_order do
    pricing_rule_id do
      PricingRule.find_or_create_by(
        attributes_for(:pricing_rule, :line_items)
      ).id
    end

    order_id { Order.find_or_create_by(attributes_for(:order)).id }
  end
end
