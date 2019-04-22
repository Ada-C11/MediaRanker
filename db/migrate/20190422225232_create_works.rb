class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :type
      t.string :title
      t.string :author
      t.integer :publication_year
      t.string :description

      t.timestamps
    end
  end
end
