class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

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

  def self.category_list(category_type)
    category_list =  Work.select { |work| work.category == category_type }
    return category_list.sort_by { |work| work.vote_count }.reverse!
  end

  def self.top_ten(category_type)
    works = Work.category_list(category_type)

    return works.first(10)
  end

  def vote_count
    return self.votes.length
  end
end