require "test_helper"

describe UsersController do
  it "gets the login path" do
    get login_path

    must_respond_with :success
  end

  # it "successfully logs a user in" do
  #   username = "cyndi"
  #   user = User.create(username: username)

  #   expect {
  #     post login_path(user)
  #   }.must_change "User.count", +1
  # end
end
