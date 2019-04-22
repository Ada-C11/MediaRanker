class RemoveColumnPublicationFromWork < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, "publication_date"
  end
end
