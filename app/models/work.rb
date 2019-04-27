class Work < ApplicationRecord
  has_many :votes, dependent: :destroy 
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
end
