class CreateMinimumOrderValue < ActiveRecord::Migration[5.2]
  def change
    create_table :restriction_type_minimum_order_values do |t|
      t.integer :value
      t.timestamps null: false
    end
  end
end
