class AddForeignkeyVotes < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :votes, :works
    add_foreign_key :votes, :users
  end
end
