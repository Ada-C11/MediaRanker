class Work < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true
  has_many :votes

  # def vote_count
  #   @work = Work.find_by(id: params[:id])
  #   @votes = Vote.find_by(work_id: @work.id)
  #   return @votes.length
  # end
end
