require "test_helper"
require "pry"

describe VotesController do
  it "should make vote" do
    Vote.delete_all
    perform_login
    work = works(:one)

    expect {
      post work_votes_path(work.id)
    }.must_change "Vote.count", 1

    expect(flash[:success]).must_equal "Successfully upvoted!"
    expect(work.id).must_equal Vote.first.work_id
    must_respond_with :redirect
  end

  it "should not let you vote if you have already voted for that media" do
    perform_login
    work = works(:one)
    post work_votes_path(work.id)

    # user = users(:one)
    # vote = Vote.new(user_id: user.id, work_id: work.id)
    # vote.save
    # why won't the above error?
    # probably why I should be more dilligent at writing tests first eh?

    expect {
      post work_votes_path(work.id)
    }.wont_change "Vote.count"

    must_respond_with :redirect
    expect(flash[:error]).must_equal "you can only vote for that work once!"
  end

  it "should not allow you to vote if you're not logged in" do
    work = works(:one)

    expect {
      post work_votes_path(work.id)
    }.wont_change "Vote.count"

    must_respond_with :redirect
    expect(flash[:error]).must_equal "you need to be logged in"
  end
end
