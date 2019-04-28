class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true

  def self.top_ten(category)
    works = self.where(category: category)

    top_works = works.sort_by { |work| work.votes.length }

    if top_works.length > 10
      return top_works.reverse.first(10)
    else
      return top_works.reverse
    end
  end

  def self.spotlight
    works = self.all

    spotlight = works.sort_by { |work| work.votes.length }

    return spotlight.last
  end
end
