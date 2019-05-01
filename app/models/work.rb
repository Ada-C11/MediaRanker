class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  has_many :votes, dependent: :destroy

  def self.sort_by_category(category)
    works_sorted_by_category = []
    
    Work.all.each do |work|
      if work.category == category
       works_sorted_by_category << work
      end
    end
    return works_sorted_by_category
  end

  def self.popular(category: nil)
    if category
      works = Work.sort_by_category(category)
    else
      works = Work.all
    end

    return works.sort_by{ |work| -work.votes.count}
  end

  def self.media_spotlight
    return popular.first
  end

  def self.top_10(category)
    return popular(category: category)[0..9]
  end

  
end # class end
