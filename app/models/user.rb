class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes
  validates :username, presence: true

  def vote_counter
    self.votes.length
  end
end
