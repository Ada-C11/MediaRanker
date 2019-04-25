class Work < ApplicationRecord
  validates :title, presence: true
  validates :publication_year, presence: true
  validates :creator, presence: true
  validates :category, presence: true
  validates :description, presence: true

  has_many :votes
  def self.category
    works = Work.all
    hash = Hash.new { }
    works.each do |work|
      category = work.category
      if !hash.include?(category)
        hash[category] = 1
      end
    end
    return hash.keys.sort
  end

  def self.media_votes(category)
    media_count_hash = {}
    works = Work.all
    works.each do |work|
      if work.category == category
        num_votes = work.votes.count
        media_count_hash[work] = num_votes
      end
    end
    media_count = self.top_ten_media_descending(media_count_hash)
    return media_count
  end

  def self.top_ten_media_descending(media_count)
    media_count = media_count.sort_by { |work, count| count }
    media_count.reverse!
    return media_count[0,9]
  end
end
