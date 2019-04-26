class AddWorkIdToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :work, foreign_key: true, index: {unique: true}, on_delete: :cascade
  end
end
