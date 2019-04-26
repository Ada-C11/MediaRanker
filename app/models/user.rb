class User < ApplicationRecord
  validates :username, presence: true
  has_many :votes
  has_many :works, through: :votes

  def self.user(user_id)
    user = User.find_by(id: user_id)
    return user
  end

  def self.vote_count(user)
    user.votes.count
  end

end
