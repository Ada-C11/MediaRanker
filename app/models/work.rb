class Work < ApplicationRecord
    belongs_to :user
    has_many :votes

    validates :category, presence: true
    validates :title, presence: true

    def self.top_ten(category)
        works = Work.where(category: category).to_a
        works.sort_by! { |work| Vote.where(work_id: work.id).length }
        unless works.nil?
          return works.reverse[0..9]
        end
    end

    def self.spotlight
       media_spotlight = Work.all.sort_by { |work| Vote.where(work_id: work.id).length}
       unless media_spotlight.nil?
        return media_spotlight.reverse[0]
       end
    end
end
