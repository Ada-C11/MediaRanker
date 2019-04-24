class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  def vote_count
    return self.votes.length
  end

  def self.top_media
    if Work.all == nil || Work.all == []
      return nil
    end

    return Work.all.max_by { |work| work.vote_count }
  end

  def self.category_list(category_type)
    category_list =  Work.select { |work| work.category == category_type }
    return category_list.sort_by { |work| work.vote_count }.reverse!
  end

  def self.top_ten(category_type)
    works = Work.category_list(category_type)

    return works.first(10)
  end

end