require "test_helper"

describe UsersController do
  describe "current do"
  it "gets the login path" do
    get login_path

    must_respond_with :success
  end

  it "returns 200 OK for a logged-in user" do
    user = User.first
    login_data = {
      user: {
        username: user.username
      }
    }

    post login_path, params: login_data

    expect(session[:user_id]).must_equal user.id

    get current_user_path

    must_respond_with :success
  # it "successfully logs a user in" do
  #   username = "cyndi"
  #   user = User.create(username: username)

  #   expect {
  #     post login_path(user)
  #   }.must_change "User.count", +1
  # end
end
