class Work < ApplicationRecord
  has_many :votes
  
  def self.albums
    return self.where(category: "album")
  end
  
  def self.books
    return self.where(category: "book")
  end
  
  def self.movies
    return self.where(category: "movie")
  end
  # def total_votes
    
  # end
end
