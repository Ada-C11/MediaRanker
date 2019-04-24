class Work < ApplicationRecord
    belongs_to :user
    has_many :votes

    validates :category, presence: true
    validates :title, presence: true

    def self.top_ten(category)
        Work.where(category: category).sample(10) 
    end
end
