class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user, uniqueness: { scope: :work, message: "has already voted for this work" }
end
