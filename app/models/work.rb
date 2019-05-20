class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true }

  has_many :votes
  has_many :users, :through => :votes
  
  def self.media_spotlight
    most_votes = 0
    spotlight_work = self.first
    Work.all.each do |work|
      if work.votes.length > most_votes
        most_votes = work.votes.length
        spotlight_work = work
      end
    end
    return spotlight_work
  end

  def self.top_ten(category)
    works = Work.where(category: category).sort_by { |work| work.votes.length }.reverse!
    if works.length > 10
      return works.first(10)
    else
      return works
    end
  end
end
