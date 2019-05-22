class RemoveIncorrectReferences < ActiveRecord::Migration[5.2]
  def change
      remove_reference :votes, :works, foreign_key: true
      remove_reference :votes, :users, foreign_key: true
    
  end
end
