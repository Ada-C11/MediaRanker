class RenameColumnOfUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :votes, :number_of_votes
    rename_column :works, :votes, :number_of_votes
  end
end
