class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true
  validates :author, presence: true
  validates :category, presence: true
  
  

  def self.top_ten(category)
    return Work.where(category: category).max_by(10) { |work| work.votes.length }
  end

end
