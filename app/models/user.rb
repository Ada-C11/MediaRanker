class User < ApplicationRecord
  validates :username, presence: true
  validates :join_date, presence: true
end
