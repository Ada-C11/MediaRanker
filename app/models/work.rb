class Work < ApplicationRecord
  has_and_belongs_to_many :users

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
end
