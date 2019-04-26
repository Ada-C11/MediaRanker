class User < ApplicationRecord
  validates :username, presence: true
  has_many :votes

  def self.user(user_id)
    user = User.find_by(id: user_id)
    return user
  end
end
