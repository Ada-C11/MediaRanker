class AddWorkIdToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :work, foreign_key: true
    add_index :votes, [:user_id, :work_id], unique: true
  end
end
