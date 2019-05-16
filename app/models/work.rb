class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true

  def self.index_media(media_type)
    collection = Work.where(category: media_type).order(votes_count: :desc)
    return collection
  end

  def self.top_media(media_type)
    collection = Work.where(category: media_type).where("votes_count > ?", 0).order(votes_count: :desc).limit(10)
    return collection
  end

  def self.media_spotlight
    top_work = Work.where("votes_count > ?", 0).order(votes_count: :desc).limit(1)[0]

    # NOTE TO DAN: I tried to break ties based on which work had the most recent vote...
    #  However, it seems like my fixture data might not be set up properly to test this.
    #  I looked up how to make fixtures based off of seeded data, but
    #  I haven't found a working solution yet.  Sorry about that! :(

    # return top_work if top_work == nil

    # tied_works = Work.where(votes_count: top_work.votes_count)
    # return top_work if tied_works.count == 1

    # most_recent_vote = Vote.where(work_id: top_work.id).order(created_at: :desc).limit(1)[0]

    # tied_works.each do |work|
    #   work.votes.each do |vote|
    #     most_recent_vote = vote if vote.created_at > most_recent_vote.created_at
    #   end
    # end

    # recently_voted_work = Work.find_by(id: most_recent_vote.work_id)[0]

    # recently_voted_work = top_work
    return top_work
  end
end
