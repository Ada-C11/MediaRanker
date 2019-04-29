class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :votes

  def self.find_top_ten(category_name)
    works = Work.where(category: category_name).sort_by { |work| work.vote_ids.length }.reverse!
    return works[0, 9]
  end

  def self.find_most_voted
    max_votes = 0
    most_voted = nil
    Work.all.each do |work|
      work_votes = work.vote_ids.length
      if work_votes >= max_votes
        max_votes = work_votes
        most_voted = work
      end
    end
    return most_voted
  end
end
