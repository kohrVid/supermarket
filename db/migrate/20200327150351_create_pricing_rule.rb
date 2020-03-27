class CreatePricingRule < ActiveRecord::Migration[5.2]
  def change
    create_table :pricing_rules do |t|
      t.string :name
      t.boolean :apply_last, default: false
      t.timestamps null: false
    end
  end
end
