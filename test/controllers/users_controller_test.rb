require "test_helper"

describe UsersController do
  it "returns a list of all users" do
    get users_path
    must_respond_with :success
  end

  it "shows a valid user" do
    user = users(:one)
    get user_path(user.id)
    must_respond_with :success
  end

  it "returns error for invalid user" do
    get user_path(-3)
    assert_equal "User not found.", flash[:error]
  end
end
