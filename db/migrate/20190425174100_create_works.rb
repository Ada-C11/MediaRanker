class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :category
      t.string :name
      t.string :created_by
      t.string :published
      t.string :description

      t.timestamps
    end
  end
end
