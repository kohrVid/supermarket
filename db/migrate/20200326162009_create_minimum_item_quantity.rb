class CreateMinimumItemQuantity < ActiveRecord::Migration[5.2]
  def change
    create_table :restriction_type_minimum_item_quantities do |t|
      t.belongs_to :item, foreign_key: true
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
