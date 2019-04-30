# frozen_string_literal: true

class Work < ApplicationRecord
  validates :title, presence: true

  has_many :votes
  has_many :users, through: :votes

  def self.top_ten(media)
    results = Work.where(media: media.to_s)
    results = results.sort_by {|result| result.votes.length}.reverse

    results = Work.where(media: media.to_s) if results.empty?

    if results.length <= 10
      return results
    else
      results = results[0..9]
    end

    results
  end

  def self.spotlight
    works = Work.all
    spotlight = works.sort_by {|work| work.votes.length}.reverse
    spotlight.first
  end

end
