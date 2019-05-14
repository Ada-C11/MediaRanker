class Vote < ApplicationRecord
  #     t.integer :user_id
  #     t.integer :work_id
  #     t.date :date
  #     t.integer :value
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates :work_id, presence: true
  validates :value, presence: true, inclusion: { in: [1, -1], message: "%{value} is not a valid vote" }

  def user
    User.find(self.user_id)
  end

  def type
    {
      1 => "upvote",
      -1 => "downvote",
    }[self.value]
  end

  def work
    Work.find(self.work_id)
  end
end
