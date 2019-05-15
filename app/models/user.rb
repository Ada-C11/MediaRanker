class User < ApplicationRecord
  has_many :votes

  validates :username, presence: true, uniqueness: true

  def self.get_date(work)
    return work.created_at.strftime('%h %d, %Y')
  end
end
