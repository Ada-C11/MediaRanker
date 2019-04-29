class Vote < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :work, optional: true
  validates :user, uniqueness: { scope: [:work], message: "has already voted for this work" }

  def self.user(user)
  end
end
