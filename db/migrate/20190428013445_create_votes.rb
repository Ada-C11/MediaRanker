class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.belongs_to :user
      t.belongs_to :work
      t.timestamps
    end
    add_index :votes, %i[user_id work_id], unique: true
  end
end
