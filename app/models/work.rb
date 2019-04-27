class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :category, presence: true, inclusion: {in: %w(album movie book)}

  def self.top_media
    if self.count == 0
      top_media = nil
    else
      works = self.all.sort_by { |work| work.votes.length }.reverse!
      top_media = works.first
    end
    return top_media
  end

  def self.top_ten(category)
    works = self.where(category: category).sort_by { |work| work.votes.length }.reverse!
    top_ten = works.first(10)
    return top_ten
  end
end
