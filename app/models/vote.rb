class Vote < ApplicationRecord
  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: :work, message: "you have already voted for this work" }
  belongs_to :work
  belongs_to :user
end
