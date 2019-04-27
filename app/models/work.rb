class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true
  validates :category, presence: true

  def self.get_top
    @works = Work.find_by_sql("SELECT COUNT(votes.work_id), works.id, title, creator, publication_year, category 
                              FROM works LEFT JOIN votes 
                              ON works.id = votes.work_id 
                              GROUP BY works.id, title, creator, publication_year, category 
                              ORDER BY COUNT(votes.work_id) desc")
  end

  # def self.spotlight
  #   return Work.all.sample(1)
  # end
end
