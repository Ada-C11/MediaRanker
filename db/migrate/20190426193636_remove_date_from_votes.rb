class RemoveDateFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column(:votes, :date)
  end
end
