class AddReferenceToUserAndWork < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :vote, foreign_key: true
    add_reference :works, :vote, foreign_key: true
  end
end
