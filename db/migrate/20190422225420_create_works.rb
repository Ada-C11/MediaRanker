class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :catagory
      t.string :title
      t.string :creator
      t.datetime :publication_year
      t.string :description

      t.timestamps
    end
  end
end
