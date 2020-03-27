class CreateReward < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.belongs_to :reward_type, foreign_key: true
      t.integer :reward_id
      t.timestamps null: false
    end
  end
end
