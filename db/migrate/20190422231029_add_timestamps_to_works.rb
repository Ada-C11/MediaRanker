class AddTimestampsToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :created_at, :datetime, null: false
    add_column :works, :updated_at, :datetime, null: false
  end
end
