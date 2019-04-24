class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true, inclusion: {in: %w(album movie book)}
end
