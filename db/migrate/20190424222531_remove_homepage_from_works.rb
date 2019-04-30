class RemoveHomepageFromWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column(:works, :homepage_id)
  end
end
