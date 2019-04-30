class ChangeDataTypesInUserTable < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :date_joined
    add_column :users, :date_joined, :datetime  
end

  def down
    remove_column :users, :date_joined
    add_column :users, :date_joined, :string
  end
end
