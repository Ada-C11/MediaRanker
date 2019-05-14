class Work < ApplicationRecord
  has_many :votes

  def votes
    Vote.where(work_id: self.id)
  end

  def upvotes
    Vote.where(work_id: self.id, value: 1)
  end

  def downvotes
    Vote.where(work_id: self.id, value: -1)
  end

  def top_voted
    Work.all.sort { |work| work.votes.sum { |vote| vote.value } }.first
  end
end
