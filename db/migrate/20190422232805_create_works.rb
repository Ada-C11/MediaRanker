class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :category
      t.string :title
      t.string :creator
      t.integer :pub_yr
      t.string :description
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
