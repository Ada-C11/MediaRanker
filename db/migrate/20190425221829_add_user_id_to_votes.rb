class AddUserIdToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :user, foreign_key: true, index: { unique: true }
  end
end
