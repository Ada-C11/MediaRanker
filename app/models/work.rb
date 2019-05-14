class Work < ApplicationRecord
    has_many :votes

    validates :title, presence: true, uniqueness: true
    validates :creator, :category, :description, :publication_year, presence: true
end
