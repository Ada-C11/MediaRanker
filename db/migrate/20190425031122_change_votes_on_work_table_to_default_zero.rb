class ChangeVotesOnWorkTableToDefaultZero < ActiveRecord::Migration[5.2]
  def change
    change_column :works, :votes, :integer, :default => 0
  end
end
