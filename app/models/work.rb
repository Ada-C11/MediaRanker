class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :category, presence: true, inclusion: {in: %w(album movie book)}

  def self.top_media
    works = self.all.sort_by { |work| work.vote_ids.length }.reverse!
    top_media = works.first
    return top_media
  end
end
