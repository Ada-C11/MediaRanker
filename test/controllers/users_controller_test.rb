require "test_helper"
require "pry"

describe UsersController do
  # let (:user) do
  #   User.create(username: "Elle")
  # end

  describe "index" do
    it "can get users index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "display a valid user" do
      # binding.pry
      valid_user_id = users(:elle).id
      get user_path(valid_user_id)
      must_respond_with :success
    end

    it "return a 404 not found when searching for a non-existant user" do
      get user_path(-1)
      must_redirect_to users_path
    end
  end

  describe "new / login" do
    it "load form for new user (login)" do
      get login_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "create a new user" do
    end

    it "re-load and show flash message if given invalid input" do
      # username can't be blank
    end
  end
end
