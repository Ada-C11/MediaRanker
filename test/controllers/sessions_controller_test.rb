require "test_helper"

describe SessionsController do
  it "can get login page" do
    get sessions_login_path
    must_respond_with :success
  end

  it "can login a valid user" do
    post login_path, params: {user: {username: "ari"}}

    expect(flash[:success]).must_include "successfully logged in"
    must_redirect_to root_path
  end

  it "can logout" do
    delete logout_path

    assert_nil(session[:user_id])
    assert_equal "Successfully logged out", flash[:success]
  end
end
