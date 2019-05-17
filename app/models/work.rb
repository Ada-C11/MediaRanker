class Work < ApplicationRecord
  validates :title, presence: true
  acts_as_votable

  has_many :users, through: :votes
  has_many :votes

  def self.works_category(category)
    return Work.where(category: category).where.not(cached_votes_total: 0).order(title: :asc)
  end

  def self.top_ten_categories(category)
    works = self.works_category(category)
    works = works.sort_by {|work| work.votes_for.size }.reverse!
  end

  def self.top_work
    top_work = Work.order(cached_votes_total: :desc).first
    top_work
  end

end
