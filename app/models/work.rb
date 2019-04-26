class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  def self.media_spotlight
    all_works = Work.all
    popular_works = all_works.sort_by { |work| work.votes.count }
    return popular_works.first
  end

  def self.top_10(category)
    work_with_category = Work.where(category: category)
    popular_works = work_with_category.sort_by { |work| work.votes.count }
    return popular_works[0..9]
  end
end
