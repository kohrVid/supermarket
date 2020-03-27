class AddPricingRuleAssociations < ActiveRecord::Migration[5.2]
  def change
    add_reference :restriction_groups, :pricing_rule, foreign_key: true
    add_reference :rewards, :pricing_rule, foreign_key: true
  end
end
