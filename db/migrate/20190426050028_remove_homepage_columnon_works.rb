class RemoveHomepageColumnonWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column(:works, :homepages_id)
  end
end
