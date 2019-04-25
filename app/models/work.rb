class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true
  validates :author, presence: true
  validates :category, presence: true
  
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
