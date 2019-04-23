class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  def self.movies_list
    return Work.select { |work| work.category == 'movie' }
  end

  def self.books_list
    return Work.select { |work| work.category == 'book' }
  end

  def self.albums_list
    return Work.select { |work| work.category == 'album' }
  end

  def self.top_media
    media_spotlight = Work.first
    max_votes = Work.first.votes.length
    Work.all.each do |work|
      if work.votes.length > max_votes
        max_votes = work.votes.length
        media_spotlight = work
      end
    end
    return media_spotlight
  end

  def self.top_movies
    top_10 = []
    movies = Work.movies_list.sort_by { |work| work.vote_count }
    movies.reverse!

    10.times do |i|
      top_10 << movies[i]
    end
    return top_10
  end

  def self.top_books
    top_10 = []
    books = Work.books_list.sort_by { |work| work.vote_count }
    books.reverse!

    10.times do |i|
      top_10 << books[i]
    end
    return top_10
  end

  def self.top_albums
    top_10 = []
    albums = Work.albums_list.sort_by { |work| work.vote_count }
    albums.reverse!

    10.times do |i|
      top_10 << albums[i]
    end
    return top_10
  end

  def vote_count
    return self.votes.length
  end
end