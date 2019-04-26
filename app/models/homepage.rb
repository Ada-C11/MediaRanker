class Homepage < ApplicationRecord
  def self.spotlight
    return Work.left_joins(:votes).select("works.*, COUNT(votes.id) as vote_count").group(:id).order("COUNT(votes.id) DESC").limit(1)[0]
  end
end
