class AddWorkrRefToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :work, foriegn_key: true
  end
end
