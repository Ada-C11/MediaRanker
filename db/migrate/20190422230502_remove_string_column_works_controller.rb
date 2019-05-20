class RemoveStringColumnWorksController < ActiveRecord::Migration[5.2]
  def change
    remove_column(:media, :string)
    rename_table(:media, :works)
  end
end
