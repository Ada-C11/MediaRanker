class DropUsersWorks < ActiveRecord::Migration[5.2]
  def down
    drop_table :users_works
  end
end
