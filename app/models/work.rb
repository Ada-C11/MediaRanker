class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true
  validates :category, presence: true

  def self.get_top
    all_works_by_category = Work.all.sample(10)

    # work_id_votes = Hash.new
    # votes = []
    # all_works_by_category.each do |work|
    #   work_id_votes[work.id] = work.votes.length
    #   votes << work.votes.length
    # end
    # sorted_votes = votes.sort
    # top_10_work = []
    # 10.times do |index|
    #   sorted_votes.each do |num_votes|
    #     top_10_work << work_id_votes.key(num_votes)
    #   end
    # end
    # return top_10_work
  end

  def self.spotlight
    return Work.all.sample(1)
  end
end
