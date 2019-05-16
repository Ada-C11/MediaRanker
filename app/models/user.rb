class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  validates :username, presence: true
  validates :join_date, presence: true
end
