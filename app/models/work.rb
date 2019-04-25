class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  # has_many :votes, dependent: :delete_all

  def self.media_spotlight
  end

  def self.top_10
  end
end # class end
