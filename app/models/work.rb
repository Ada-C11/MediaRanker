class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  validates :title, presence: true
  validates :author, presence: true
  validates :category, presence: true
  
  

  def self.top_ten(category)
    top_ten = Work.where(category: category).max_by(10) { |work| work.votes.length }
    
    if top_ten.empty?
      top_ten = "There are no #{category}s right now. Go add some!"
    end
    return top_ten
  end

end
