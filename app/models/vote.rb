# frozen_string_literal: true

class Vote < ApplicationRecord
  validates :work_id, presence: true
  validates :user_id, presence: true, :uniqueness => { :scope => :work_id }


  belongs_to :work
  belongs_to :user
end
