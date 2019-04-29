class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, :through => :votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
end
