class Work < ApplicationRecord
  def self.top_ten(category)
    works = Work.where(category: category.to_s)
    if works.length <= 10
      return works
    else
      return works.sample(10)
    end
  end

  def self.spotlight
    works = Work.all
    return works.first
  end
end
