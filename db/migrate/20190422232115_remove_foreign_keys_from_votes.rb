class RemoveForeignKeysFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :votes, :users
    remove_foreign_key :votes, :works
  end
end
