class AddUserandWorktoVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, foreign_key: true
    add_reference :works, foreign_key: true
  end
end
