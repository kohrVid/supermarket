class CreateRestrictionTable < ActiveRecord::Migration[5.2]
  def change
    create_table :restrictions do |t|
      t.belongs_to :restriction_group, foreign_key: true
      t.belongs_to :restriction_type, foreign_key: true
      t.integer :restriction_id
      t.timestamps null: false
    end
  end
end
