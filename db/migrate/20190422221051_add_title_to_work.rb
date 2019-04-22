class AddTitleToWork < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :title, :string
  end
end
