class AddCategoryIdToWorks < ActiveRecord::Migration[5.2]
  def change
    add_reference :works, :category, foreign_key: true
  end
end
