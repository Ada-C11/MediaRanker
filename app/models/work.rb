class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :votes
  has_many :users, through: :votes

  def vote_counter
    return self.votes.length
  end

  def self.spotlight_work(works)
    spotlight_work = works.first
    works.each do |work|
      if work.vote_count == nil
        return nil
      elsif work.vote_count > spotlight_work.vote_count
        spotlight_work = work
      end
    end
    return spotlight_work
  end

  def self.top_ten_books(works)
    top_books = []
    sorted_works = works.order(:vote_count).reverse
    sorted_works.each do |work|
      if work.category == "book"
        top_books << work
      end
    end

    return top_books[0..9]
  end

  def self.top_ten_albums(works)
    top_albums = []
    sorted_works = works.order(:vote_count).reverse
    sorted_works.each do |work|
      if work.category == "album"
        top_albums << work
      end
    end
    return top_albums[0..9]
  end

  def self.top_ten_movies(works)
    top_movies = []
    sorted_works = works.order(:vote_count).reverse
    sorted_works.each do |work|
      if work.category == "movie"
        top_movies << work
      end
    end
    return top_movies[0..9]
  end
end
