require "test_helper"

describe VotesController do
  before do
    @gump = works(:gump)
  end

  describe "add_vote" do
    it "adds a vote if an existing user hasn't voted for the work yet" do
      user = perform_login

      post vote_work_path(@gump.id)

      expect(@gump.votes.count).must_equal 1
      expect(user.votes.count).must_equal 2

      must_respond_with :redirect
      must_redirect_to work_path(@gump)
    end

    it "won't add the vote if the existing user has already voted for that work" do
      user = perform_login

      post vote_work_path(@gump.id)

      expect(@gump.votes.count).must_equal 1
      expect(user.votes.count).must_equal 2

      expect { post vote_work_path(@gump.id) }.wont_change "#{@gump.votes.count}"

      expect(@gump.votes.count).must_equal 1
      expect(user.votes.count).must_equal 2

      must_respond_with :redirect
      must_redirect_to work_path(@gump.id)
    end

    it "won't let a user vote if they're not logged in" do
      expect { post vote_work_path(@gump.id) }.wont_change "#{@gump.votes.count}"
      expect(@gump.votes.count).must_equal 0

      must_respond_with :redirect
      must_redirect_to work_path(@gump.id)
    end
  end
end
