class Work < ApplicationRecord
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

  def self.top_ten_albums
    albums_array = []
    10.times do
      albums_array << Work.albums.sample
    end
    return albums_array
  end

  def self.top_ten_books
    books_array = []
    10.times do
      books_array << Work.books.sample
    end
    return books_array
  end
end
