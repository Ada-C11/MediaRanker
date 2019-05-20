class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  has_many :votes, dependent: :destroy

  def self.top_ten(type)
    array_by_type = self.where(category: type)

    if array_by_type.length > 1
      array_by_votes = array_by_type.sort_by { |work| -work.votes.count }

      if array_by_votes.length < 10
        return array_by_votes
      else
        return array_by_votes[0..9]
      end
    else
      return array_by_type
    end
  end

  def self.media_spotlight
    all_works = self.all

    sorted_works = all_works.sort_by { |work| -work.votes.count }
    spotlight = sorted_works.first

    return spotlight
  end
end
