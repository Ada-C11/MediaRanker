class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  validates :title, :creator, :category, presence: true

  def self.top_work
    featured = Work.all.order("votes_count desc").first

    return featured
  end

  def self.top_ten(category)
    top_works = Work.where(category: category).order("votes_count desc").first(10)

    return top_works
  end
end
