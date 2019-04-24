class User < ApplicationRecord
  has_many :votes
  validates :username, presence: true, uniqueness: true

  def has_voted?(work_id)
    votes = self.votes
    return votes.find_by(work_id: work_id)
  end
end