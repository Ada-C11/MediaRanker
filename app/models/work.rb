class Work < ApplicationRecord
  has_many :votes
  validates :title, uniqueness: true, presence: true
  
  def self.top_ten(category)
    works = Work.where(category: category).to_a
    works.sort_by! { |work| Vote.where(work_id: work.id).length }
    unless works.nil?
      return works.reverse[0..9]
    end
  end

  def self.sort_media(category)
    works = Work.where(category: category).to_a
    works.sort_by! { |work| Vote.where(work_id: work.id).count }
    return works.reverse
  end

end
