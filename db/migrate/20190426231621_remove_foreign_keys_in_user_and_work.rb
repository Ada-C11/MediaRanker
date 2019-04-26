class RemoveForeignKeysInUserAndWork < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :users, column: :vote_id
    remove_foreign_key :works, column: :vote_id
  end
end
