class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  def vote_counter
    self.votes.length
  end
end
