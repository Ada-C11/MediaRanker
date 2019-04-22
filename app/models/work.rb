class Work < ApplicationRecord
  def spotlight
    return Work.all.sample
  end

  def top_ten
    10.times do
      Work.all.sample
    end
  end
end
