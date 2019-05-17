class User < ApplicationRecord
  validates :username, presence: true
  has_many :votes


  acts_as_voter
end
