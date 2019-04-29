class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, uniqueness: true
  validates :work_id, uniqueness: true
end
