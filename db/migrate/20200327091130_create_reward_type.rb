class CreateRewardType < ActiveRecord::Migration[5.2]
  def change
    create_table :reward_types do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
