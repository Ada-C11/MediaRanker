class Work < ApplicationRecord
  validates :title, presence: true
  validates :publication_year, presence: true
  validates :creator, presence: true
  validates :category, presence: true
  validates :description, presence: true

  has_many :votes
  def self.category(works)
    hash = Hash.new { }
    works.each do |work|
      category = work.category
      if !hash.include?(category)
        hash[category] = 1
      end
    end
    return hash.keys.sort
  end
end
