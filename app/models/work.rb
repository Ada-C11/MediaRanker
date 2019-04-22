class Work < ApplicationRecord
  validates :title, presence: true
  validates :creator, presence: true
end
