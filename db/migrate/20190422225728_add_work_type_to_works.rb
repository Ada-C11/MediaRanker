# frozen_string_literal: true

class AddWorkTypeToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column(:works, :type, :string)
  end
end
