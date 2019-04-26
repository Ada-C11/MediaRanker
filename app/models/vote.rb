class Vote < ApplicationRecord
  belongs_to :works
  belongs_to :users

  # validates :users, uniqueness: {scope: :work, message: "you have already voted"}

end
