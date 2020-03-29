class CreatePricingRuleOrder < ActiveRecord::Migration[5.2]
  def change
    create_table :pricing_rule_orders do |t|
      t.belongs_to :pricing_rule, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.timestamps null: false
    end
  end
end
