class Work < ApplicationRecord
  validates :title, presence: true
  validates :creator, presence: true
  validates :category, presence: true, inclusion: { in: %w(album book movie) }

  has_many :votes, dependent: :destroy

  def self.top_ten(category)
    works_in_category = self.where(category: category).sort_by { |work| work.votes.count }
    if works_in_category.length > 10
      return works_in_category.reverse[0...10]
    else
      return works_in_category.reverse
    end
  end

  def self.spotlight
    return self.all.max_by { |work| work.votes.count }
  end
end
