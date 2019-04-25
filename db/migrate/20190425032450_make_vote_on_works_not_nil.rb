class MakeVoteOnWorksNotNil < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :votes
  end
end
