class Work < ApplicationRecord
  has_many :votes
  validates :title, uniqueness: true, presence: true

end
