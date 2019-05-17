class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :description, presence: true

  def self.find_highest
    max = Work.all.max_by { |work| Vote.where(work_id: work.id).count }
    return max
  end
  def self.list_works(type)
    results = Work.all.select do |work|
      work.category == type
    end
    rez = results.sort_by! { |work| Vote.where(work_id: work.id).count }
    return rez.reverse
    #Vote.where(work_id: work.id).count
  end
end
