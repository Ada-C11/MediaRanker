require "test_helper"

describe UsersController do
  it "can get a list of all users" do
    get users_path
    must_respond_with :success
  end

  it "can show a user" do
    get users_path
    must_respond_with :success
  end

  # it "can make a new user" do
  #   expect(user = User.new).must_change '
end
