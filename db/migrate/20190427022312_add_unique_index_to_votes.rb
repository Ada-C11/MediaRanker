class AddUniqueIndexToVotes < ActiveRecord::Migration[5.2]
  def change
    add_index :votes, [:user_id, :work_id], unique: true
  end
end
