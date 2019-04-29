class Work < ApplicationRecord
  has_many :upvotes, dependent: :destroy
  
  validates :category, presence: true, inclusion: {in: ["book", "album", "movie"]}
  validates :title, presence: true
 
  # helper methods to return lists by category
  def self.top_ten_list(category)
    list = self.where(category: category).to_a
    list.sort_by! { |media| media.upvotes.count }
    return list.reverse.first(10)
  end

  # logic for top ten votes
  def self.list(category)
    return self.where(category: category)
  end

  def self.spotlight
    return max_votes = self.all.max_by { | work |
     work.upvotes.count   
    }  
  end
end