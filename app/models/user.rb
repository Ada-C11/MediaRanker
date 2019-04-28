class User < ApplicationRecord
  validates :username, presence: true
  has_many :votes, dependent: :destroy

  # j_index, an implementation of the Jaccard index formula, calculates the similarity
  # between a user and another user by taking the ratio of common upvotes to the unique
  # set of all upvotes between the two users.
  def j_index(other)
    user_works = self.votes.map { |vote| vote.work }
    other_works = other.votes.map { |vote| vote.work }
    common_works = user_works & other_works
    upvoted_works = (user_works + other_works).uniq
    return (common_works.count) / (upvoted_works.count)
  end

  # get_similar_users returns a list of all other users stored in db, ranked by similarity.
  # Useful for implementing a friend recommendation system
  def get_similar_users
    users = User.all.clone
    other_users = users.delete(user)
    sorted_by_similarity = other_users.sort_by { |other| j_index(self, other) }.reverse
    return sorted_by_similarity
    return
  end

  # get_recommendations returns a list of works by other users ranked by the average
  # j_index of other users who liked the work, and the user the method is called on.
  def get_reccommendations
    reccommendations = Hash.new { |hash, key| hash[key] = 0 }
    users = User.all.clone
    other_users = users.delete(user)
    other_users.each do |other|
      difference = self.votes.map { |vote| vote.work.id } - other.votes.map { |vote| vote.work.id }
      difference.each do |work_id|
        reccommendations["#{work_id}"][j_index_sum] += j_index(other)
        reccommendations["#{work_id}"][users_count] += 1
      end
      ranked_recommendations = reccommendations.keys.sort_by { |key| reccommendations[key][j_index_sum] / reccommendations[key][user_count] }
      return ranked_recommendations.reverse
    end
  end
end
