class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  # validates :user, uniqueness: { scope: :work, message: "has already voted for this work"}
  validates :user, uniqueness: { scope: :work }

  validates :work_id, presence: true

  # def upvote
  #   votes.count
  # end
end
