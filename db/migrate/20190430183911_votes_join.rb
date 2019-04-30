class VotesJoin < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :work, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
