require "test_helper"

describe VotesController do
  describe "create" do
    it "can create a new vote" do
      # Arrange
      user_params = {
        user: {
          username: "panicpixels",
        },
      }

      vote_params = {
        vote: {},
      }

      post login_path, params: user_params

      expect {
        post work_votes_path(Work.last.id), params: vote_params
      }.must_change "Vote.count", +1

      must_respond_with :redirect
    end

    it "will not create a vote if a user isn't logged in" do
      vote_params = {
        vote: {},
      }
      expect {
        post work_votes_path(Work.last.id), params: vote_params
      }.wont_change "Vote.count"

      must_respond_with :redirect
    end

    it "will not create a vote if a user has already voted for the work" do
      user_params = {
        user: {
          username: "panicpixels",
        },
      }

      vote_params = {
        vote: {},
      }

      # log in
      post login_path, params: user_params

      # vote once
      post work_votes_path(Work.last.id), params: vote_params

      # and vote again for the same thing
      expect {
        post work_votes_path(Work.last.id), params: vote_params
      }.wont_change "Vote.count"

      must_respond_with :redirect
    end

    it "will create a vote if a user votes for a different work" do
      user_params = {
        user: {
          username: "panicpixels",
        },
      }

      vote_params = {
        vote: {},
      }

      # log in
      post login_path, params: user_params

      # vote once
      post work_votes_path(Work.last.id), params: vote_params

      # and vote again for something else
      expect {
        post work_votes_path(Work.first.id), params: vote_params
      }.must_change "Vote.count", +1

      must_respond_with :redirect
    end
  end
  it "can delete a vote" do
    user_params = {
      user: {
        username: "panicpixels",
      },
    }

    vote_params = {
      vote: {},
    }

    post login_path, params: user_params
    user = User.find_by(username: user_params[:user][:username])
    post work_votes_path(Work.last.id), params: vote_params

    new_vote = Vote.where(user_id: user.id, work_id: Work.last.id)[0]
    expect {
      delete vote_path(id: new_vote.id)
    }.must_change "Vote.count", -1

    must_respond_with :redirect
  end
end
