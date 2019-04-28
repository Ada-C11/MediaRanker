class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  # I added this before I decided to do a current user path. Do I need this, then?
  def self.current(session)
    return nil unless session[:user_id]

    User.find_by(id: session[:user_id])
  end
end
