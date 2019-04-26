class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :votes
  has_many :users, through: :votes

  def vote_counter
    return self.votes.length
  end

  def self.spotlight_work(works)
    spotlight_work = works.first
    works.each do |work|
      if work.vote_counter > spotlight_work.vote_counter
        spotlight_work = work
      end
    end
    return nil if spotlight_work.vote_counter == 0
    return spotlight_work
  end

  def self.top_ten(works, category)
    top_works = []
    sorted_works = works.order(:vote_count).reverse
    sorted_works.each do |work|
      if work.category == category
        top_works << work
      end
    end

    return top_works[0..9]
  end
end
