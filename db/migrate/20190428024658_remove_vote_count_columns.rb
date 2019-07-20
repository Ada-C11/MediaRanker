class RemoveVoteCountColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :vote_count
    remove_column :users, :vote_count
  end
end
