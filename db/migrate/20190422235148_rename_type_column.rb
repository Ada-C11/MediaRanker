class RenameTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :type, :category
  end
end
