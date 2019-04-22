class Work < ApplicationRecord
  def self.movies
   return self.where(category: "movie")
  end

  def self.albums
    return self.where(category: "album")
  end

  def self.books
    return self.where(category: "book")
  end
end
