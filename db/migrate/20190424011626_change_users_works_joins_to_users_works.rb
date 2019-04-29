class ChangeUsersWorksJoinsToUsersWorks < ActiveRecord::Migration[5.2]
  def change
    rename_table :users_works_joins, :users_works
  end
end
