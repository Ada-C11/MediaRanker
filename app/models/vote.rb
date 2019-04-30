class Vote < ApplicationRecord
  belongs_to :work, counter_cache: :vote_count
  belongs_to :user

  validates :user_id, presence: true
  validates :work_id, presence: true

end