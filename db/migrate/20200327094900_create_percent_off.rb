class CreatePercentOff < ActiveRecord::Migration[5.2]
  def change
    create_table :reward_type_percent_offs do |t|
      t.decimal :percentage
      t.timestamps null: false
    end
  end
end
