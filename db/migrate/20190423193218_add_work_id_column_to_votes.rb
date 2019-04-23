class AddWorkIdColumnToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column(:votes, :work_id, :integer)
  end
end
