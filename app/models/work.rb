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

  def self.spotlight
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
end
