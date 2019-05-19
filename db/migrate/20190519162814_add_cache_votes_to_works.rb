# frozen_string_literal: true

class AddCacheVotesToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :cached_votes_total, :integer, default: 0
    add_index :works, :cached_votes_total
    add_column :works, :cached_votes_up, :integer, default: 0
    add_column :works, :cached_votes_down, :integer, default: 0
    add_index  :works, :cached_votes_up
    add_index  :works, :cached_votes_down
  end
end
