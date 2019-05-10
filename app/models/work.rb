class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes, dependent: :destroy
  validates :title, presence: true

  def self.get_media_categories
    books = self.get_media("books")
    albums = self.get_media("albums")
    movies = self.get_media("movies")
    return [books, albums, movies]
  end

  def self.get_media(media_type)
    media = Work.where(category: media_type)
  end

  # return top ten works
  def self.top_media
    top_works = get_media_categories.map do |category|
      category[0..9]
    end
    return top_works
  end

  def self.spotlight
    spotlight = Work.all.max_by { |work| work.votes.count }
    return spotlight
  end
end
