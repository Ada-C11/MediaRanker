class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  has_many :votes, dependent: :destroy

  def self.sort_by_category(category)
    works_sorted_by_category = []
    
    Work.all.each do |work|
      if work.category == category
       works_sorted_by_category << work
      end
    end
    return works_sorted_by_category
  end

  def self.top_10
    @top_10_works_sorted_by_category = sort_by_category(category)
    top_10 = @top_10_works_sorted_by_category.sort_by {|work| work.votes.count}.reverse!
    return top_10
  end
  
end # class end
