require_relative "../../lib/models/pricing_rule.rb"
require_relative "../../lib/models/order.rb"

FactoryBot.define do
  factory :pricing_rule_order do
    pricing_rule_id { create(:pricing_rule, :line_items).id }
    order_id { create(:order).id }
  end
end
