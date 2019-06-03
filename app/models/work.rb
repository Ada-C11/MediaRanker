class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  def self.albums
    Work.select { |work| work.category == "album" }
  end

  def self.books
    Work.select { |work| work.category == "book" }
  end

  def self.movies
    Work.select { |work| work.category == "movie" }
  end

  def self.spotlight
    Work.all.max_by { |work| work.votes.length }
  end
end
