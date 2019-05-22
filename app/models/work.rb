class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true

  def self.top(category)
    all_category = Work.where(category: category)
    work_votes = all_category.sort_by{|work| work.votes.length}.reverse
    top_ten = work_votes[0,10]
    return top_ten
  end

  def self.spotlight
    spotlight = Work.all.sample(1).first
    return spotlight
  end

end
