class AddUserRefToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :user, foriegn_key: true
  end
end
