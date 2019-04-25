require "test_helper"

describe UsersController do
  let(:kim) { users(:kim) }
  let(:aj) { useres(:aj) }

  describe "index" do
    it "can get index" do
      get users_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can show an existing valid user" do
      valid_id = kim.id

      get user_path(valid_id)

      must_respond_with :success
    end

    it "redirects to the root path for an invalid user id" do
      invalid_id = -1

      get user_path(invalid_id)

      must_respond_with :redirect
      must_redirect_to root_path
      expect(flash[:failure]).must_equal "User Not Found."
    end
  end

  describe "login form" do
    it "can get the login form" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    it "can login an existing user" do
      user_hash = {
        user: {
          username: User.first.username,
          join_date: User.first.join_date,
        },
      }

      expect {
        post login_path, params: user_hash
      }.wont_change "User.count"
    end

    it "should"
  end
end
