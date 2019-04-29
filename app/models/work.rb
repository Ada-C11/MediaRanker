class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true

  def self.top
    Work.all.max_by do |work| work.votes.length end
  end

  def self.list_by_votes(category)
    list = Work.where(category: category)
    sorted_list = list.sort_by { |work| -work.votes.length }
    return sorted_list
  end

  def self.top_ten(category)
    list = Work.list_by_votes(category)
    return list[0...10]
  end
end
