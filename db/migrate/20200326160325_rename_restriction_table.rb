class RenameRestrictionTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :restrictions, :restriction_types
  end
end
