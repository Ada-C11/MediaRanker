class Work < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true
  has_many :votes

  def self.spotlight
    # max = 0
    # spotlight = nil
    # Work.all.each do |work|
    #   unless work.votes.length < max
    #     max = work.votes.length
    #     spotlight = work
    #   end
    # end
    # return spotlight
    return Work.all.sort_by { |work| work.votes.length }.last
  end

  def self.top_ten_movies
    movies = Work.where(category: "movie").sort_by { |work| work.votes.length }.reverse
    if movies.length >= 10
      top_ten_movies = movies.first(10)
    else
      top_ten_movies = movies
    end
    return top_ten_movies
  end
  def self.top_ten_books
    books = Work.where(category: "book").sort_by { |work| work.votes.length }.reverse
    if books.length >= 10
      top_ten_books = books.first(10)
    else
      top_ten_books = books
    end
    return top_ten_books
  end
  def self.top_ten_albums
    albums = Work.where(category: "album").sort_by { |work| work.votes.length }.reverse
    if albums.length >= 10
      top_ten_album = albums.first(10)
    else
      top_ten_album = albums
    end
    return top_ten_album
  end
end
