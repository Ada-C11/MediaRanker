class Vote < ApplicationRecord
  validates :user_id, presence: true
  belongs_to :work
  belongs_to :user
end
