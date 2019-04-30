# frozen_string_literal: true

class EnableIntarrayExtension < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'intarray'
  end
end
