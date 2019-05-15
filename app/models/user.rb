class User < ApplicationRecord
  validates :username, presence: true
  has_many :votes, dependent: :destroy

  # j_index, an implementation of the Jaccard index formula, calculates the similarity
  # between a user and another user by taking the ratio of common upvotes to the unique
  # set of all upvotes between the two users.
  def j_index(other)
    user_upvotes = self.votes.where(value: 1).map { |vote| vote.work }
    user_downvotes = self.votes.where(value: -1).map { |vote| vote.work }
    other_upvotes = other.votes.where(value: 1).map { |vote| vote.work }
    other_downvotes = other.votes.where(value: -1).map { |vote| vote.work }

    common_upvotes = user_upvotes & other_upvotes
    common_downvotes = user_downvotes & other_downvotes
    user_downvote_other_upvote = user_downvotes & other_upvotes
    user_upvote_other_downvote = user_upvotes & other_downvotes

    all_voted_works = (user_upvotes + other_upvotes + user_downvotes + other_downvotes).uniq

    return ((common_upvotes.count + common_downvotes.count) - (user_downvote_other_upvote.count + user_upvote_other_downvote.count)) / (all_voted_works.count.to_f)
  end

  # get_similar_users returns a list of all other users stored in db, ranked by similarity.
  # Useful for implementing a friend recommendation system
  def get_similar_users
    users = User.where.not(id: self.id)
    sorted_by_similarity = users.sort_by { |other| j_index(other) }.reverse
    return sorted_by_similarity
  end

  # get_recommendations returns a list of works by other users ranked by the average
  # j_index of other users who liked the work, and the user the method is called on.
  def get_recommendations
    recommendations = Hash.new { |hash, key| hash[key] = { j_index_sum: 0, users_count: 0 } }
    users = User.where.not(id: self.id)
    users.each do |other|
      difference = other.votes.map { |vote| vote.work.id } - self.votes.map { |vote| vote.work.id }
      difference.each do |work_id|
        recommendations["#{work_id}"][:j_index_sum] += j_index(other)
        recommendations["#{work_id}"][:users_count] += 1
      end
      ranked_recommendations = recommendations.keys.sort_by { |key| recommendations[key][:j_index_sum] / recommendations[key][:users_count] }

      return ranked_recommendations
    end
  end
end
