class User < ApplicationRecord
  has_many :votes

  validates :name, presence: true, exclusion: { in: ["", nil] }
end
