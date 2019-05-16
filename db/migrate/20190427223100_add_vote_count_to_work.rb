class AddVoteCountToWork < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :votes_count, :integer, default: 0
  end
end
