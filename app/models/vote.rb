class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work_id, presence: true
  validates :user_id, presence: true

  def self.upvote(date: date, work_id: work_id, user_id: user_id)
    votes_for_work = Vote.where(work_id: work_id)
    existing_vote_from_user = votes_for_work.find_by(user_id: user_id)
    if existing_vote_from_user
      return nil
    else
      return vote = Vote.create(date: date, work_id: work_id, user_id: user_id)
    end
  end
end
