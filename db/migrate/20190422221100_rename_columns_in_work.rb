class RenameColumnsInWork < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, "published_year"
    remove_column :works, "media_type_id"
    add_column :works, "category", :string
    add_column :works, "description", :string
    add_column :works, "publication_date", :date
  end
end
