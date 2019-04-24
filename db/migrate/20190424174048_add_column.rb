class AddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :date_voted, :datetime
  end
end
