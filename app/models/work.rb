class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  # Must have a title
  validates :title, presence: true

  def self.index_media(media_type)
    collection = Work.where(category: media_type)
    return collection
  end

  def self.top_media(media_type)
    collection = Work.where(category: media_type).order(votes_count: :desc).limit(10)
    # collection = Work.where(category: media_type).sample(10)
    return collection
  end

  def self.media_spotlight
    top_work = Work.order(votes_count: :desc).limit(1)[0]
    return top_work
  end
end
