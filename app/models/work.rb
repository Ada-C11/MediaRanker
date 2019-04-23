class Work < ApplicationRecord
  validates :title, presence: true

  def spotlight
    return self.sample
  end

  def top_book
    return self.sample
  end

  def top_album
    return self.sample
  end

  def top_movie
    return self.sample
  end
end
