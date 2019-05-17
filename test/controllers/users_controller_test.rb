require "test_helper"
require "pry"

describe UsersController do
  it "should get index" do
    get users_path

    must_respond_with :success
  end

  it "should get show" do
    get user_path(users(:one).id)
    must_respond_with :success
  end

  it "allows a user to log in" do
    user = perform_login

    expect(session[:user_id]).must_equal user.id
    expect(flash[:success]).must_equal "Successfully logged in as returning user #{user.username}"
    must_redirect_to root_path

    #why is it doing returning user and not new user?

    #I get the test to pass but also get this warning that I'd like to understand
    #DEPRECATED: Use assert_nil if expecting nil from test/controllers/users_controller_test.rb:26. This will fail in Minitest 6.
  end

  it "allows a user to log out" do
    perform_login

    post logout_path
    expect(session[:user_id]).must_equal nil
    expect(flash[:success]).must_equal "Successfully logged out"
    must_redirect_to root_path
  end

  it "will display a page with no users" do
    User.destroy_all

    get users_path

    must_respond_with :success
  end
end
