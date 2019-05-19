# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates :work_id, presence: true
  validates :value, presence: true, inclusion: { in: [1, -1], message: '%{value} is not a valid vote' }

  def user
    User.find(user_id)
  end

  def type
    {
      1 => 'upvote',
      -1 => 'downvote'
    }[value]
  end

  # def work
  #   @work = Work.find(work_id)
  # end
end
