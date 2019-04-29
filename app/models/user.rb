class User < ApplicationRecord
    has_many :works
    has_many :votes

    validates :username, presence: true
end
