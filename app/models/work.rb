class Work < ApplicationRecord
  # has_many :upvotes
  
  validates :category, presence: true
  validates :title, presence: true
 
  # helper methods to return lists by category
  def self.list(category)
   return self.where(category: category)
  end

  # logic for top ten votes
  def self.top_ten(category)
    return self.where(category: category).max_by { |work| work.votes.length }
  end
end