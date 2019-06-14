class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all
  has_many :users, through: :votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: {scope: :category}

  def self.list_of(work_category)
    work_list = Work.all.select { |work| work.category == work_category }
    return sort_by_votes(work_list)
  end

  def self.spotlight
    return sort_by_votes(Work.all).first
  end

  def vote_count
    return self.votes.length
  end

  private

  def self.sort_by_votes(work_list)
    return work_list.sort_by { |work| [-work.votes.length, work.title] }
  end
end
