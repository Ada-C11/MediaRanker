class RenameCatagoryToCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :catagory, :category
  end
end
