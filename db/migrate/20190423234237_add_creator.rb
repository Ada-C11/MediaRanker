class AddCreator < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :creator, :string
  end
end
