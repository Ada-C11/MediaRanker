class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  def voter_name
    user = User.find_by(id: self.user_id)
    return user.username
  end

  def created_date
    return self.created_at.strftime("%B %d, %Y")
  end
end
