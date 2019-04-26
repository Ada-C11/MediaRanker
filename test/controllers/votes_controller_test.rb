require "test_helper"

describe VotesController do
  describe "create" do
    
    it "creates a new vote" do
      # perform_login
      
      user = users(:test)
      vote_data = {
        vote: {
          user_id: user.id,
          work_id: works(:moon).id
        }
      }
      
          @vote = Vote.new(work_id:vote_data[:work_id], user_id: user.id)
      
      
      expect(@vote.save).must_change "Vote.count", +1
      
      
    end
  end
end
