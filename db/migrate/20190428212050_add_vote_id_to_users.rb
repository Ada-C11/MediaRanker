class AddVoteIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :vote, foreign_key: true
  end
end
