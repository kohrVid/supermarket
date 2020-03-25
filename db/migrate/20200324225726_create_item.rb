class CreateItem < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.belongs_to :currency, foreign_key: true
      t.timestamps null: false
    end
  end
end
