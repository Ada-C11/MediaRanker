class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, :work, :date, presence: true
end
