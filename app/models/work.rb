class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :category, presence: true, inclusion: { in: %w(album book movie) }
end
