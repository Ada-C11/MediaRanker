class Work < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true
  has_many :votes

  def self.spotlight
    max = 0
    spotlight = nil
    Work.all.each do |work|
      unless work.votes.length < max
        max = work.votes.length
        spotlight = work
      end
    end
    return spotlight
  end
end
