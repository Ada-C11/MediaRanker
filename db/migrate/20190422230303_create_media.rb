class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.string :category
      t.string :title
      t.string :string
      t.string :creator
      t.integer :publication_year
      t.string :description

      t.timestamps
    end
  end
end
