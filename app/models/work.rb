class Work < ApplicationRecord
  validates :title, presence: true

  has_many :votes
  has_many :users, through: :votes

  def self.topten(work)
    results = Work.where(category: work)
    results = results.sort_by { |result| result.votes.length }.reverse

    results = Work.where(category: work) if results.empty?

    if results.length <= 10
      return results
    else
      results = results[0..9]
    end

    results
  end
end
