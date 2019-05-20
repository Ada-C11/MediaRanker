class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def self.top_ten(category)
    return self.sort_work_by_votes(Work.all.where(category: category))[0..9]
  end

  def self.spotlight
    return self.sort_work_by_votes(Work.all).first
  end

  private

  def self.sort_work_by_votes(works)
    return works.sort_by do |work|
             -work.votes.count
           end
  end
end
