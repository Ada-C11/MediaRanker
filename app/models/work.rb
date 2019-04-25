class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true
  validates :category, presence: true, inclusion: {in: %w(album book movie)}

  def self.sort_work(category)
    works = Work.where(category: category).to_a
    works.sort_by! { |work| Vote.where(work_id: work.id).length }
    return works.reverse
  end

  def self.highest_vote
    works = Work.all.to_a
    works.sort_by! { |work| Vote.where(work_id: work.id).length }
    return works.reverse[0]
  end

  def self.top_ten(category)
    works = Work.where(category: category).to_a
    works.sort_by! { |work| Vote.where(work_id: work.id).length }
    return works.reverse[0..9]
  end
end
