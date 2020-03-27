class RenameRestrictionTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :restriction_types, :type, :name
  end
end
