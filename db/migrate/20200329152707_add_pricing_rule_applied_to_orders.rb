class AddPricingRuleAppliedToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :pricing_rules_applied, :boolean, default: false
  end
end
