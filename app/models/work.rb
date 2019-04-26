class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  has_many :votes, dependent: :destroy

  def self.sort_by_category(category)
    # sort work by category
    return Work.where(category: category)
  end

  def self.popular(category = nil)
    # if there is a category, save the works in that category to the variable popular_works
      if category
        popular_works = Work.sort_by_category(category)
        
      # if there is no category, resturn all works
      else
        popular_works = Work.all
      end

      # sort the works in the popular_works variable by the number of votes
      # return works
      return popular_works.sort_by { |work| -work.votes.count }
  end

  def self.media_spotlight
    # the work with the most votes
    # return the first work in popular

    # most_popular = popular.first
    # return most_popular
    return popular.first
  end

  #### LOGIC SEEMS FAULTY ####
  def self.top_10(category)
    return popular(category: category)[0..9]
    
    # popular_works_in_category = popular(category)

    # if popular_works_in_category.category == "album"
    #   return popular_works_in_category[1..10]

    # elsif popular_works_in_category.category == "book"
    #   return popular_works_in_category[1..10]

    # elsif popular_works_in_category.category == "movie"
    #   return popular_works_in_category[1..10]
    # end
  end
end # class end
