class Work < ApplicationRecord
  belongs_to :category
  validates :title, presence: true, uniqueness: true

  has_many :votes
  has_many :users, through: :votes
end
