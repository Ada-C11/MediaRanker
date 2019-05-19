class User < ApplicationRecord
  has_many :votes
  acts_as_voter
  validates :name, presence: true, exclusion: { in: ['', nil] }
end
