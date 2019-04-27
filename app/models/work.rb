class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :category, presence: true, inclusion: {in: %w(album movie book)}

  def self.top_media
    top_media = self.first
    return top_media
  end
end
