class CreateWorksUsersJoin < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.belongs_to :work, index: true
      t.belongs_to :user, index: true
    end
  end
end
