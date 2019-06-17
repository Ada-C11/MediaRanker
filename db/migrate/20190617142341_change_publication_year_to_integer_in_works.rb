class ChangePublicationYearToIntegerInWorks < ActiveRecord::Migration[5.2]
  def change
    change_column :works, :publication_year, :integer, using: "publication_year::integer"
  end
end
