class AddColumnToWorksTable < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :title, :string
  end
end
