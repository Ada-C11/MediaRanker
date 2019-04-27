class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  has_many :votes

  def vote_count
    self.votes.length
  end

  def self.top_ten(type)
    array_by_type = Work.where(category: type)

    array_by_votes = array_by_type.sort_by { |work| -work.votes.count }

    if array_by_votes.length < 10
      return array_by_votes
    else
      return array_by_votes[0..9]
    end
  end

  # def top_ten(type)
  #   array_by_type = self.where(category: type)
  #   array_by_votes = array_by_type.sort_by { |work| -work.votes.count }
  #   top_10 = sorted_array[0..9]
  #   if array_by_votes.length < 10
  #     return array_by_votes
  #   else
  #   return array_by_votes[0..9]
  # end
end
