class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  has_many :votes

  def vote_count
    self.votes.length
  end
end
