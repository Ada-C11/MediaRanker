class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :description, presence: true, uniqueness: true
  validates :publication_year, presence: true
end
