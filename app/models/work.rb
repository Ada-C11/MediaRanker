class Work < ApplicationRecord
  def self.albums
    where(category: "album")
  end
  def self.books
    where(category: "book")
  end
  def self.movies
    where(category: "movie")
  end

  def self.spotlight
    # all.first
    spotlight_criteria = self.maximum("publication_year")
    spotlight = self.find_by(publication_year: spotlight_criteria)
  end
end
