class Work < ApplicationRecord
  def self.category(works)
    hash = Hash.new { }
    works.each do |work|
      category = work.category
      if !hash.include?(category)
        hash[category] = 1
      end
    end
    return hash.keys.sort
  end
end
