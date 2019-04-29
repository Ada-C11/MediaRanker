class AddVotesToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :votes, :integer
  end
end
