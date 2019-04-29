class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  def self.vote(user, work)
    return Vote.find_by(user_id: user, work_id: work)
  end
end
