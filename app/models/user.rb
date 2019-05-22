class User < ApplicationRecord
  has_many :upvotes
  has_many :works, through: :upvotes
  validates :username, presence: true, uniqueness: true
end
