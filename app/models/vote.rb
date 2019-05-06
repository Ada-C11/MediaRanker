class Vote < ApplicationRecord
  #     t.integer :user_id
  #     t.integer :work_id
  #     t.date :date
  #     t.integer :value
  belongs_to :user
  belongs_to :work
  #TODO: ensure value is 1 or -1

  def user
    User.find(self.user_id)
  end

  def type
    {
      1 => "upvote",
      -1 => "downvote",
    }[self.value]
  end
end
