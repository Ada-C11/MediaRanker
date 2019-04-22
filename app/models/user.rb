class User < ApplicationRecord
  has_and_belongs_to_many :works

  validates :name, presence: true, uniqueness: true
end
