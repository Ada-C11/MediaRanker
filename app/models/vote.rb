# class GoodnessValidator < ActiveModel::Validator
#   def validate(vote)
#     user = User.find_by(id: :user_id)
#     work = Work.find_by(id: :work_id)
#     if Vote.find_by(user: user, work: work)
#       vote.send(field) == "user"
#       vote.errors[:details] << "has already voted for this work"
#     end
#   end
# end

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, presence: true
  validates :work, presence: true

  validates :user, uniqueness: {scope: [:work], message: "has already voted for this work"}

  # validates_with GoodnessValidator, fields: [:user_id, :work_id]
end
