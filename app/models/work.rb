class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  def self.categories
    return ["movie", "book", "album"]
  end

  def self.highlight
    works = Work.all
    works.max_by { |work| work.votes.count }
  end

  def self.top_works(category)
    all_works = Work.where(category: category)
    unless all_works == []
      return all_works.max_by(10) { |work| work.votes.count }
    else
      return []
    end
  end

  def vote_count
    return self.votes.count
  end

  def self.category_all(category)
    all = Work.where(category: category)
    return all
  end

  def created_date
    return self.created_at.strftime("%B %d, %Y")
  end
end
