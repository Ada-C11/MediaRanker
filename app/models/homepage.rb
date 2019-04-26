class Homepage < ApplicationRecord
  def self.top_media
    Work.all.max_by do |work| work.votes.length end
  end

  def self.top_ten(type)
    list = Work.where(category: type).sort_by do |media| -media.votes.length end
    return list[0...10]
  end
end
