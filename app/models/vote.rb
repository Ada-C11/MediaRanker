class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # def is_revote?(user_id, work_id)
  #   return Vote.find_by(user_id: user_id, work_id: work_id)
  # end
end
