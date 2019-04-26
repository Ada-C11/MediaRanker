class AddUserAndWorkToUpvote < ActiveRecord::Migration[5.2]
  def change
    add_reference :upvotes, :user, foreign_key: true
    add_reference :upvotes, :work, foreign_key: true
  end
end
