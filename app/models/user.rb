class User < ApplicationRecord
  has_many :votes

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
