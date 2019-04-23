class DropUsersWorks2 < ActiveRecord::Migration[5.2]
  def change
    drop_join_table :users, :works
  end
end
