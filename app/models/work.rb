class Work < ApplicationRecord
  validates :title, presence: true

  def self.get_media_catagories
    books = Work.where(category: "book")
    albums = Work.where(category: "album")
    movies = Work.where(category: "movie")
    return [books, albums, movies]
  end

  def self.top_media
    top_works = get_media_catagories.map { |category| category.sample(10) }
    return top_works
  end

  def self.spotlight
    return Work.all.sample
  end
end
