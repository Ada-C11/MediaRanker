class AddVoteCountColumnToWork < ActiveRecord::Migration[5.2]
  def change
    def change
      add_column :works, :vote_count, :integer
    end
  end
end
