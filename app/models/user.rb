class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  #   def vote_count
  #     self.votes.length
  #   end
end
