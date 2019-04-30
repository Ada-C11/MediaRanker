class ChangeVoterIdColumnsInVotes < ActiveRecord::Migration[5.2]
  def change
    rename_column(:votes, :votable_id, :work_id)
    rename_column(:votes, :voter_id, :user_id)
  end
end
