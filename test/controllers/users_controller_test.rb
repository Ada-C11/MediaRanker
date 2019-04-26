require "test_helper"
require "pry"

describe UsersController do
  let (:user) do
    @elle = User.create(username: "Elle")
  end

  describe "index" do
    it "can get users index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "display a valid user" do
      get user_path(@elle.id)
      binding.pry
      must_respond_with :success
    end

    it "return a 404 not found when searching for a non-existant user" do
      get user_path(-1)
      must_redirect_to users_path
    end
  end
end
