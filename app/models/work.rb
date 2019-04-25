class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  # has_many :votes

  def self.sort_by_category(category)
    # sort work by category
  end

  def self.most_popular
    # the top 10 works in each category by number of votes
  end

  def self.media_spotlight
    # the work with the most votes
  end



end # class end
