class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true

  def self.top_ten(category)
    top_works = self.top_voted(category)

    if top_works.length > 10
      return top_works.first(10)
    else
      return top_works
    end
  end

  def self.spotlight
    works = self.all

    spotlight = works.sort_by { |work| work.votes.length }

    return spotlight.last
  end

  def self.top_voted(category)
    works = self.where(category: category)

    return works.sort_by { |work| work.votes.length }.reverse
  end
end
