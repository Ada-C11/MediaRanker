require "test_helper"

describe UpvotesController do
  let(:work) { works(:album) }
  
  describe "create" do 

    it "allows a logged in user to vote" do 
      user = perform_login(users(:first_user))
      work = works(:album)

      upvote_hash = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      expect {
        post work_upvotes_path(work.id), params: upvote_hash
      }.must_change "Upvote.count", +1

      must_respond_with :redirect
      check_flash

    end

    it "doesn't allow votes when not logged in" do 
      upvote_hash = {
        vote: {
          user_id: nil,
          work_id: work.id,
        },
      }

      expect {
        post work_upvotes_path(work.id), params: upvote_hash
      }.wont_change "Upvote.count"

      check_flash(:error)

      must_respond_with :redirect
    end

    it "doesn't allow a user to vote for a work more than once" do 
      user = perform_login(users(:first_user))
      work = works(:album)

      upvote_hash = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      check_flash

      post work_upvotes_path(work.id), params: upvote_hash

      expect {
        post work_upvotes_path(work.id), params: upvote_hash
      }.wont_change "Upvote.count"

      check_flash(:error)
      must_respond_with :redirect
      # in this test, it will redirect to root path but in controller, 
      # it will redirect back to the referrer
      must_redirect_to root_path
    end

    it "will not post an invalid vote to the database" do 
    end
  end

end
