class AddIndexToVotes < ActiveRecord::Migration[5.2]
  def change
    remove_index :votes, column: :work_id
    remove_index :votes, column: :user_id
    add_index :votes, [:user_id, :work_id], unique: true
  end
end
