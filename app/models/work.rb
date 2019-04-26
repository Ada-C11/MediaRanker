class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  def self.top_media
    if Work.all == nil || Work.all == []
      return nil
    end

    return Work.all.max_by { |work| work.vote_count }
  end

  def self.category_list(category)
    category_list =  Work.select { |work| work.category == category }
    return category_list.sort_by { |work| work.vote_count }.reverse!
  end

  def self.top_ten(category)
    works = Work.category_list(category)

    return works[0..9]
  end

  def vote_count
    return self.votes.length
  end

end