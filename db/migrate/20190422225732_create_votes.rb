class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.date :date
      t.datetime :created_at
      t.datetime :updated_at
      t.bigint :user_id
      t.bigint :work_id

      t.timestamps
    end
  end
end
