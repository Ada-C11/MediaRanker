class AddForeignKeysToVotes < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :votes, :works, foreign_key: true, on_delete: :cascade
    add_foreign_key :votes, :users, foreign_key: true, on_delete: :cascade
  end
end
