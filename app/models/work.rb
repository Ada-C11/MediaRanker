# frozen_string_literal: true

class Work < ApplicationRecord
  has_many :votes
  acts_as_votable

  def votes
    votes = Vote.where('votable_id = ?', id)
    puts 'vote.all.count', Vote.all.count
    votes
  end

  def self.upvote(id)
    puts id.to_s
  end
end
