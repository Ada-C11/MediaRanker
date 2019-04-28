class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  def self.top_ten(category)
    works = Work.where(category: category)

    top_works = works.sort_by { |work| work.votes.length }

    if top_works.length > 10
      return top_works.reverse.first(10)
    else
      return top_works.reverse
    end
  end

  def self.spotlight
    works = Work.all

    spotlight = works.sort_by { |work| work.votes.length }

    return spotlight.last
  end
end
