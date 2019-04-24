require "test_helper"

describe UsersController do
  let (:user_one) {
    users(:user_one)
  }
  describe "login_form" do
    it "should get login form" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    it "can log in an existing user" do
    end

    it "can log in a new user" do
    end
  end
end
