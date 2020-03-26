class CreateRestrictionGroup < ActiveRecord::Migration[5.2]
  def change
    create_table :restriction_groups do |t|
      t.timestamps null: false
    end
  end
end
