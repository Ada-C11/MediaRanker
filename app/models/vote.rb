class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user, uniqueness: { scope: :work }
end
