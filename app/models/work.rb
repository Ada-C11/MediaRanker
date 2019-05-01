class Work < ApplicationRecord
  validates :title, presence: true

  has_many :votes
  has_many :users, through: :votes

  def self.top_ten(works)
    # sort through works
    # reverse and display top 10.
  end
end
