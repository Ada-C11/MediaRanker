# frozen_string_literal: true

class DropVotes < ActiveRecord::Migration[5.2]
  def change
    drop_table(:votes)
  end
end
