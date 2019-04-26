class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  has_many :votes, dependent: :destroy

  
end # class end
