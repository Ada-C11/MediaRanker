class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  def self.check_unique_work(user_id, work_id)
    user = User.find(user_id)
    vote = Vote.find_by(user: user_id)
    if vote.work_id == work_id
      return false
    else
      return true
    end
  end

  def self.vote(user, work)
    return Vote.find_by(user_id: user.id, work_id: work.id)
  end

  
end
