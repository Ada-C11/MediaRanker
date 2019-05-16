class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  def already_voted?(work)
    return self.works.include?(work)
  end

  def created_date
    return self.created_at.strftime("%B %d, %Y")
  end

  def voted_date(work)
    vote_array = Vote.where({user_id: self.id, work_id: work.id})
    if vote_array.length > 0
      date = vote_array[0].created_at.strftime("%B %d, %Y")
    else
      return nil
    end
    return date
  end
end
