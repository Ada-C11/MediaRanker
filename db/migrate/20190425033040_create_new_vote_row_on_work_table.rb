class CreateNewVoteRowOnWorkTable < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :votes, :integer, :null => false, :default => 0
  end
end
