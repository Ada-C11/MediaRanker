class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, uniqness: true
  validates :work_id, uniqness: true
end
