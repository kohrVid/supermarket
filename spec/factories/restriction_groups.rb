FactoryBot.define do
  factory :restriction_group do
    pricing_rule_id do
      PricingRule.find_or_create_by(
        attributes_for(:pricing_rule, :line_items)
      ).id
    end
  end
end
