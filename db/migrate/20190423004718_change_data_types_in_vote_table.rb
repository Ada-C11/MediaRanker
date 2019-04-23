class ChangeDataTypesInVoteTable < ActiveRecord::Migration[5.2]
  def up
    change_column :votes, :user_id, 'integer USING CAST(user_id AS integer)'
    change_column :votes, :work_id, 'integer USING CAST(work_id AS integer)'
  end

  def down
    change_column :votes, :user_id, :string
    change_column :votes, :work_id, :string
  end
end
