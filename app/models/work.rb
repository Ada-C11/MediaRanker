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

  def self.top(category)
    full_collection = Work.where(category: category).order("lower(publication_year) DESC")
    top_ten = []
    position = 0
    full_collection.each do |work|
      if position <= 9
        top_ten << work
      else
        return top_ten
      end
      position += 1
    end
    #return top_ten
  end
end
