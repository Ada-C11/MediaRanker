class RemoveMediaIdFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :media_id
  end
end
