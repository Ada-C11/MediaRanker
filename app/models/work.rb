class Work < ApplicationRecord
  belongs_to :homepage
  validates :title, presence: true
  validates :title, uniqueness: true
end
