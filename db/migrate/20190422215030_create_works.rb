class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.integer :media_type_id
      t.string :title
      t.string :creator
      t.integer :published_year

      t.timestamps
    end
  end
end
