class AddVoteUserWorkRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :votes
    add_reference :votes, :work
    add_reference :votes, :user
  end
end
