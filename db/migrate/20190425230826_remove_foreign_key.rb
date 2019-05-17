class RemoveForeignKey < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :votes, :works
    remove_foreign_key :votes, :users
  end
end
