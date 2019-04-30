class RenameTypeColumnInWorks < ActiveRecord::Migration[5.2]
  def change
    rename_column(:works, :type, :media)
  end
end
