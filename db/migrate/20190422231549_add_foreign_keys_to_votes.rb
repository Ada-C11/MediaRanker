class AddForeignKeysToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :users, foreign_key: true, on_delete: :cascade
    add_reference :votes, :works, foreign_key: true, on_delete: :cascade
  end
end
