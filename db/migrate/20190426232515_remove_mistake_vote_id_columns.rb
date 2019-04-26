class RemoveMistakeVoteIdColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :vote_id
    remove_column :users, :vote_id
  end
end
