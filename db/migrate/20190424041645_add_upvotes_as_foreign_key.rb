# frozen_string_literal: true

class AddUpvotesAsForeignKey < ActiveRecord::Migration[5.2]
  def change
    remove_column(:works, :upvotes)
  end
end
