class RemoveIDfromVote < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :work_id
  end
end
