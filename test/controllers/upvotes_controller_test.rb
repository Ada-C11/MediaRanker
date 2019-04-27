require "test_helper"

describe UpvotesController do
  
  describe "create" do 
  vote = Vote.new
  
    it "verifies that a user is logged in" do 
      expect(session[:user_id]).must_be_nil

    end

    it "allows a logged in user to vote" do 

    end
  end

end
