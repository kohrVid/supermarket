class CreateValueOff < ActiveRecord::Migration[5.2]
  def change
    create_table :reward_type_value_offs do |t|
      t.integer :value
      t.timestamps null: false
    end
  end
end
