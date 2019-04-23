class RemoveJoinDateFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column(:users, :join_date)
  end
end
