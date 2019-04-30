class AddHomepageIdToWorks < ActiveRecord::Migration[5.2]
  def change
    add_reference :works, :homepage, foreign_key: true
  end
end
