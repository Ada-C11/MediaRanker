class User < ApplicationRecord
  validates :username, presence: true
  has_many :votes, dependent: :destroy
end
