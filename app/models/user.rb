class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :votes, :dependent => :destroy
  has_many :works, through: :votes
end
