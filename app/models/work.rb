class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
end
