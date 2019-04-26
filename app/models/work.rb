class Work < ApplicationRecord
  validates :title, presence: true
  validates :creator, presence: true
  validates :category, presence: true, inclusion: { in: %w(album book movie) }

  has_many :votes, dependent: :destroy

  def self.top_ten(category)
    if self.where(category: category).length > 10
      return self.where(category: category).sample(10)
    else
      return self.where(category: category)
    end
  end
end
