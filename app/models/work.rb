class Work < ApplicationRecord
  def albums
    return Work.where(category: "album")
  end

  def books
    return Work.where(category: "book")
  end

  def spotlight
    return Work.all.sample
  end

  def top_ten_albums
    albums_array = []
    10.times do
      albums_array << albums.sample
    end
    return albums_array
  end

  def top_ten_books
    books_array = []
    10.times do
      books_array << books.sample
    end
    return books_array
  end
end
