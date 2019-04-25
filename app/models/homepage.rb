class Homepage < ApplicationRecord
  def self.spotlight
    return Work.where(category: "album").left_joins(:votes).group(:id).order("COUNT(votes.id) DESC").limit(1)[0]
  end
end
