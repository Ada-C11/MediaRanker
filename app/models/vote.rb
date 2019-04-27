class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # validation for non repeating votes
  # validation :user_id, uniqueness { scope: work_id }
end
