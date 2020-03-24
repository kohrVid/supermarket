class CreateCurrency < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :code
      t.timestamps null: false
    end
  end
end
