class CreateWorksTable < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|

      t.string :creator
      t.integer :publication_year
      t.string :category
      t.string :description
    end
  end
end
