class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true

  def self.get_media_catagories
    books = Work.where(category: "book")
    albums = Work.where(category: "album")
    movies = Work.where(category: "movie")
    return [books, albums, movies]
  end

  def self.top_media
    top_works = get_media_catagories.map do |category|
      max = category.max_by(10) { |work| work.votes.count }
      max.sort_by! { |work| work.votes.count * -1 }
    end
    return top_works
  end

  def self.spotlight
    spotlight = Work.all.max_by { |work| work.votes.count }
    return spotlight
  end
end
