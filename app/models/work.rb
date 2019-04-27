class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true

  def self.albums
    return Work.where(category: "album")
  end

  def self.books
    return Work.where(category: "book")
  end

  def self.movies
    return Work.where(category: "movie")
  end

  def self.spotlight
    return Work.all.sample
  end

  def self.top_ten(works)
    sorted_works = works.sort_by {|work| work.votes.count }
    if sorted_works.count < 10
      top_ten_works = sorted_works
    else 
      top_ten_works = sorted_works.slice(0..9)
    end
    return top_ten_works
  end

end
