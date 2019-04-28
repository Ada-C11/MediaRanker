require "test_helper"

describe VotesController do
  before do
    @work = works(:book_1)
    @user = perform_login
  end

  it "should allow user to upvote when the user is logged in and has not voted on the media before" do
    expect {
      post work_votes_path(@work.id)
    }.must_change "Vote.count", 1

    expect(flash[:success]).must_equal "Successfully upvoted!"
    expect(@work.vote_ids.last).must_equal Vote.last.id
    expect(@user.vote_ids.last).must_equal Vote.last.id
  end

  it "should not allow user to vote for the same media more than once" do
    # 1st vote
    post work_votes_path(@work.id)

    # 2nd vote
    expect {
      post work_votes_path(@work.id)
    }.wont_change "Vote.count"

    expect(flash[:error]).must_equal "user: has already voted for this work"
  end

  it "should not allow up vote when the user is not logged in" do
    post logout_path

    post work_votes_path(@work.id)

    expect(flash[:error]).must_equal "You must login to vote"
  end
end
