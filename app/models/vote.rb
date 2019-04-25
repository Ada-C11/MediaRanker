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

  # def sort_votes_descending
  #   votes_hash = Hash.new
  #   @votes.each do |vote|
  #     work = Work.find_by(vote.work_id)
  #   end
  # end
end
