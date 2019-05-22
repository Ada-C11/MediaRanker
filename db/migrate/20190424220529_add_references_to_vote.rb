class AddReferencesToVote < ActiveRecord::Migration[5.2]
  def change
      add_reference :votes, :works, foreign_key: true
      add_reference :votes, :users, foreign_key: true
  
  end
end
