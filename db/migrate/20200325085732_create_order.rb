class CreateOrder < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :subtotal
      t.integer :total
      t.belongs_to :currency, foreign_key: true
      t.timestamps null: false
    end
  end
end
