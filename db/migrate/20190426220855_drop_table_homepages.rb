class DropTableHomepages < ActiveRecord::Migration[5.2]
  def change
    drop_table :homepages
  end
end
