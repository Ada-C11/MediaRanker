class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true
  validates :author, presence: true
  validates :category, presence: true
  
  # def top_ten(array)
  #   return array.max_by(10) { |work| work.votes.length }
  # end
  

def self.top_ten(category)
  return Work.where(category: category).max_by(10) { |work| work.votes.length }
end

  
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
