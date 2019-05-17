class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.date :vote_date
      t.integer :user_id
      t.integer :work_id

      t.timestamps
    end
  end
end
