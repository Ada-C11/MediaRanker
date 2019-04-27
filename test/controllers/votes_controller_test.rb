require "test_helper"

describe VotesController do
  it "should make vote" do
    tester = votes(:vote_1)
    @vote = Vote.new(user_id: tester.user, work_id: tester.work)

    expect {
      post @vote
    }.must_change "Vote.count", 1
  end
end
