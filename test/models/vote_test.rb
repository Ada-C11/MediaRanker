require "test_helper"

describe Vote do
  let(:work) { works(:summer)}
  let(:user) { users(:niv)}
  let(:vote) { Vote.create(date: Date.today, work_id: work.id, user_id: user.id)}

  it "must be valid" do
    value(vote).must_be :valid?
  end

  it "will not create a second vote with the same work and user" do
    vote
    second_vote = Vote.create(date: Date.today, work_id: work.id, user_id: user.id)
    value(second_vote).wont_be :valid?
  end

  it "can get work from vote" do
    expect(vote.work).must_equal work
  end

  it "can get user from vote" do
    expect(vote.user).must_equal user
  end


end

