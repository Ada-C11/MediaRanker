class AddHomepageToWorks < ActiveRecord::Migration[5.2]
  def change
    add_reference :works, :homepages, foreign_key: true
  end
end
