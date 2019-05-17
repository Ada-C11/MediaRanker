class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.string :creator
      t.string :category
      t.string :description
      t.integer :pub_year

      t.timestamps
    end
  end
end
