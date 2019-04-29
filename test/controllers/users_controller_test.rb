require "test_helper"

describe UsersController do
    it "should get index" do
      get works_url
      value(response).must_be :successful?
    end
  
    describe "show" do
      it "should get show" do
        valid_user_id = users(:one_u).id
  
        get users_url(valid_user_id)
        value(response).must_be :successful?
      end
  
      it "should give a flash notice instead if invalid work" do
        invalid_id = users(:one_u).id
        users(:one_u).destroy
  
        get user_path(invalid_id)
  
        must_respond_with :redirect
        expect(flash[:error]).must_equal "Unknown user"
      end
    end 
  
end
