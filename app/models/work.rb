class Work < ApplicationRecord
  # belongs_to :users
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true
end
