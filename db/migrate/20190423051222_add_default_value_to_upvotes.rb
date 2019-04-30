# frozen_string_literal: true

class AddDefaultValueToUpvotes < ActiveRecord::Migration[5.2]
  def change
    change_column :works, :upvotes, :integer, default: 0
  end
end
