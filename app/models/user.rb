class User < ApplicationRecord
  has_many :upvotes
  validates :username, presence: true, uniqueness: true
end
