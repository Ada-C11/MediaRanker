class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true, uniqueness: true

  def self.spotlight
    spotlight_work = Work.all.max_by {|work| work.votes.count}
  end

  def self.top_ten(category)
    sorted_works = Work.where(category: category).sort_by {|work| work.votes.count }.reverse!
    if sorted_works.count < 10
      top_ten_works = sorted_works
    else 
      top_ten_works = sorted_works.first(10)
    end
    return top_ten_works
  end
end
