class Work < ApplicationRecord
  belongs_to :category
  validates :title, presence: true, uniqueness: {scope: :category}

  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  def self.most_voted
    max_votes = 0
    most_voted = nil
    Work.all.each do |work|
      if work.votes.count > max_votes
        max_votes = work.votes.count
        most_voted = work
      end
    end
    most_voted
  end

  def self.top_ten(name)
    category = Category.find_by(name: name)
    works = Work.where(category: category).sort_by { |work| work.votes.count }.reverse!
    works.take(10)
  end
end
