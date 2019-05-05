class Vote < ApplicationRecord
  #      t.integer :user_id
  #     t.integer :work_id
  #     t.date :date
  belongs_to :user
	belongs_to :work
end
