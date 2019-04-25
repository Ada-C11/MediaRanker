class Work < ApplicationRecord
  has_many :votes

  # def list_works(type)
  #   results = @works.select do |work|
  #     category == type
  #   end
  #   return results
  # end
end
