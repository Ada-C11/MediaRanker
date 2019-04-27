class Work < ApplicationRecord
  has_many :upvotes
  
  validates :category, presence: true
  validates :title, presence: true
 
  # helper methods to return lists by category
  def self.top_ten_list(category)
    list = self.where(category: category)
    sorted_list =list.sort_by { |media| media.upvotes.count }
    return sorted_list.reverse!.first(10)
  end

  # logic for top ten votes
  def self.list(category)
    return self.where(category: category)
  end

  def self.spotlight
    max_votes = self.all.max_by { | work |
     work.upvotes.count   
    }  

    return max_votes
  end
end