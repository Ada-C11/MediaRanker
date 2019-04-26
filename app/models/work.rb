class Work < ApplicationRecord
  validates :title, presence: true
  validates :publication_year, presence: true
  validates :creator, presence: true
  validates :category, presence: true
  validates :description, presence: true

  has_many :votes
  has_many :users, through: :votes

  def self.category
    return ["album", "book", "movie"]
  end

  # def self.list_sorted_media_per_category(category)
  #   works = Work.where(category: category).vot
  # end

  # def self.vote_count(work)
  #   return work.votes.count
  # end

  def self.media_votes(category)
    works = Work.where(category: category).left_joins(:votes).select("works.*, COUNT(votes.id) as vote_count").group(:id).order("COUNT(votes.id) DESC").limit(10)
    return works
  end

  def self.top_ten_media_votes(category)
    return self.media_votes(category).limit(10)
  end
end
