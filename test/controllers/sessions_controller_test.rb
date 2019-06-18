require "test_helper"

describe SessionsController do
  it "can login a valid user" do
    user = users(:one)
    get sessions_login_path

    #assert_equal "#{user.username} successfully logged in", flash[:success]
    flash[:success].should =~ /#{user.username} successfully logged in/i
    must_redirect_to root_path
  end

  it "can logout" do
    delete logout_path

    assert_nil(session[:user_id])
    assert_equal "Successfully logged out", flash[:success]
  end
end
