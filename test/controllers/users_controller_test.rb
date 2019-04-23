require "test_helper"

describe UsersController do
  describe "index" do
    it "can get index" do
      get users_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get the show for a valid/logged in user" do
    end

    it "redirects to the root path for invalid/logged out user" do
    end
  end
end
