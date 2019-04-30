class User < ApplicationRecord
  has_many :votes

  def has_voted?(work_id)
    votes = self.votes
    return votes.find_by(work_id: work_id)
  end

  validates :username, presence: true, uniqueness: true
end