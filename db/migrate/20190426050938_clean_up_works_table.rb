# frozen_string_literal: true

class CleanUpWorksTable < ActiveRecord::Migration[5.2]
  def change
    remove_column(:works, :cached_votes_total)
    remove_column(:works, :cached_votes_up)
    remove_column(:works, :cached_votes_down)
  end
end
