class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true 
  has_many :votes
end
