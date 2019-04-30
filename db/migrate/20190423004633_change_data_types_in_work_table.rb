class ChangeDataTypesInWorkTable < ActiveRecord::Migration[5.2]
  def up
    change_column :works, :description, :text
    change_column :works, :publication_year, 'integer USING CAST(publication_year AS integer)'
  end

  def down
    change_column :works, :description, :string
    change_column :works, :publication_year, :string
  end
end
