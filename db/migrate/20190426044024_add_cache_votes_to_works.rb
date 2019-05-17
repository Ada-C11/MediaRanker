class AddCacheVotesToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :cached_votes_total, :integer, default: 0
    add_index  :works, :cached_votes_total
  end
end
