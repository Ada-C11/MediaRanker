class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: true

  def self.media_spotlight
    all_works = Work.all
    if all_works.length > 0
      popular_works = all_works.sort_by { |work| -work.votes.count }
      return popular_works.first
    else
      return nil
    end
  end

  def self.top_10(category)
    work_with_category = Work.where(category: category)
    if work_with_category.length > 0
      popular_works = work_with_category.sort_by { |work| -work.votes.count }
      if popular_works.length >= 10
        return popular_works[0..9]
      else
        return popular_works
      end
    else
      return nil
    end
  end
end
