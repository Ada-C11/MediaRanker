class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  
  # def self.top_ten
  #   self.max(10)
  # end
end
