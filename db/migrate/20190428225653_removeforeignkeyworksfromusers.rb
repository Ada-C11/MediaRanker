class Removeforeignkeyworksfromusers < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :works, :users
  end
end
