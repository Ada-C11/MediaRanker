class Work < ApplicationRecord
  def self.top_ten(category)
    if self.where(category: category).length > 10
      return self.where(category: category).sample(10)
    else
      return self.where(category: category)
    end
  end
end
