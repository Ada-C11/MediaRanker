class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.string :created_by
      t.integer :published
      t.integer :upvotes
      t.string :description

      t.timestamps
    end
  end
end
