require "test_helper"

describe SessionsController do
  it "can login" do
    get sessions_login_path
    value(response).must_be :successful?
  end

  it "can logout" do
    delete logout_path

    assert_nil(session[:user_id])
    assert_equal "Successfully logged out", flash[:success]
  end
end
