class Homepage < ApplicationRecord
  def self.spotlight
    return Work.all.sample
  end
end
