require "test_helper"

describe VotesController do
  describe "create" do
    it "upvotes" do
      user = User.create(username: "test")
      user = perform_login(user)
      work = Work.first

      vote_data = {
        vote: {
          work_id: work.id,
          user_id: user.id,
        },
      }
      
      post upvote_work_path(work.id), params: vote_data
  

      must_respond_with :redirect
      must_redirect_to user_path(user.id)

    end
  end
end
