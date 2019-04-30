class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates :user, uniqueness: { scope: :work }
 

  validates :work_id, presence: true

end
