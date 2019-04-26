class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :category, presence: true, inclusion: {in: %w(album movie book)}
  # validates :votes, uniqueness: {scope: :user}
end
