class Work < ApplicationRecord
  # has_many :upvotes
  
  validates :category, presence: true
  validates :title, presence: true
 

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
