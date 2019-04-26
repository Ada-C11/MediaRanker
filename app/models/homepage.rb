class Homepage < ApplicationRecord
  has_many :works
  # has_many :votes, through :works

  def work_spotlight
    ranked_works = self.works.order(:id)

    return ranked_works.first
  end

  def top_10_work
    ranked_works = self.works.order(:id)

    return ranked_works.length < 10 ? ranked_works : ranked_works[0..10]
    #   return ranked_works
    # else
    #   return ranked_works[0..10]
    # end
  end
end
