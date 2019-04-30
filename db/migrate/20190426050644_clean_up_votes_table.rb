# frozen_string_literal: true

class CleanUpVotesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column(:votes, :votable_type)
    remove_column(:votes, :voter_type)
    remove_column(:votes, :vote_flag)
    remove_column(:votes, :vote_scope)
    remove_column(:votes, :vote_weight)
  end
end
