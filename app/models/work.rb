class Work < ApplicationRecord
  # has_many :votes
  # has_many :users, through: :votes
  belongs_to :homepage

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
end
