class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :user_id, uniqueness: { scope: :work_id }

  #   def top_ten_books
  #     top_books = self.
  #   end
end
