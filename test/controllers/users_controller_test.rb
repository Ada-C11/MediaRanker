require "test_helper"

describe UsersController do
  describe "login_form" do
    it "should get login form" do
      get login_path

      must_respond_with :success
    end 
  end 
end
