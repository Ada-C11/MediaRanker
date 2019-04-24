class Work < ApplicationRecord
  validates :title, uniqueness: true, presence: true
end
