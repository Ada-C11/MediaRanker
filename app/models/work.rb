class Work < ApplicationRecord
  # has_many :votes
  # has_many :users, through: :votes
  # belongs_to :homepage

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true

  def spotlight
    ranked_works = self.sample #.order(:votes)

    return ranked_works
  end

  def top_10_work
    ranked_works = self.sample(10) #.order(:votes)

    return ranked_works.length < 10 ? ranked_works : ranked_works[0..10]
    #   return ranked_works
    # else
    #   return ranked_works[0..10]
    # end
  end
end
