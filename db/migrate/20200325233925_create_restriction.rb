class CreateRestriction < ActiveRecord::Migration[5.2]
  def change
    create_table :restrictions do |t|
      t.string :type
      t.timestamps null: false
    end
  end
end
