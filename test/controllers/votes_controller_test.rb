require "test_helper"

describe VotesController do

    # before do
    #   @user = User.create(name: "Angry Tester")
    #   # session[:user_id] = @user.id
    #   @work = Work.create(title: "test", author: "test author", publication_year: 4000, category: "album", description: "descriptive")
    #   @vote = Vote.create(work_id: @work.id, user_id: @user.id)
    #   @work_id = @vote.work_id
      
      
    #   @work = works(:moon)
    # end
    
  before do
    @user = perform_login
    @work = works(:moon)
    end
  describe "create" do  
    it "will save a new vote and redirect if given valid inputs" do  
      Vote.delete_all
      expect {
        post work_votes_path(@work.id)
      }.must_change "Vote.count", +1

      expect(flash[:success]).must_equal "Thanks for your vote!"
      expect(@work.vote_ids.first).must_equal Vote.first.id
      expect(@user.vote_ids.first).must_equal Vote.first.id
      must_respond_with :redirect
    end

    it "should not allow user to vote on media that they've already voted on" do
      post work_votes_path(@work_id)

      expect {
        post work_votes_path(@work_id)
      }.wont_change "Vote.count"

      expect(flash[:error]).must_equal "HEY! You already voted for that."
    end

    it "should not allow a user to vote if they aren't logged in" do
      post logout_path

      post work_votes_path(@work.id)

      expect(flash[:error]).must_equal "You must be logged in to vote."
    end
  end
end
