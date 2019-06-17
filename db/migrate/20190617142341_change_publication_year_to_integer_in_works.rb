class ChangePublicationYearToIntegerInWorks < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE works ALTER COLUMN publication_year TYPE integer USING (publication_year::integer)"
  end
end
