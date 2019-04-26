class Homepage < ApplicationRecord
  has_many :works
  has_many :votes, through :works

  def spotlight
    #return self.order(:votes).last
  end

  def top_10
  end
end
