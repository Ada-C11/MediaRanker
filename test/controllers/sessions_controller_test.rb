require "test_helper"

describe SessionsController do
  it "can get login page" do
    get sessions_login_path
    must_respond_with :success
  end

  # Also unsure how to get login test to work

  # it "can login a valid user" do
  #   user = User.create(username: "cindy", joined: Date.today)
  #   post login_path

  #   #assert_equal "#{user.username} successfully logged in", flash[:success]
  #   flash[:success].should =~ /#{user.username} successfully logged in/i
  #   must_redirect_to root_path
  # end

  it "can logout" do
    delete logout_path

    assert_nil(session[:user_id])
    assert_equal "Successfully logged out", flash[:success]
  end
end
