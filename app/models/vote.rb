class Vote < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :work, optional: true
  validates :user, uniqueness: { scope: [:work] }

  def self.user(user)
  end
end
