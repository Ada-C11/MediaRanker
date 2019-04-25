class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :description, presence: true

  # def list_works(type)
  #   results = @works.select do |work|
  #     category == type
  #   end
  #   return results
  # end
end
