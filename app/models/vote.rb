class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, presence: true
  validates :user_id, uniqueness: { scope: [:work], message: "has already voted for this work"}

  validates :work_id, presence: true

  # def upvote
  #   votes.count
  # end
end
