class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes, dependent: :destroy
  validates :title, presence: true

  def self.get_media_catagories
    books = get_media("book")
    albums = get_media("album")
    movies = get_media("movie")
    return [books, albums, movies]
  end

  def self.get_media(media_type)
    media = Work.where(category: media_type)
    media.sort_by { |work| work.votes.count * -1 }
  end

  def self.top_media
    top_works = get_media_catagories.map do |category|
      category[0..9]
    end
    return top_works
  end

  def self.spotlight
    spotlight = Work.all.max_by { |work| work.votes.count }
    return spotlight
  end
end
