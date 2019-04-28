require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    value(user).must_be :valid?
  end

  # move this
  it "returns 200 OK for a logged-in user" do
    user = User.first
    login_data = {
      user: {
        username: user.name,
      },
    }
    post login_path, params: login_data
  end

  expect(session[:user_id]).must_equal user.id

  # get current_user_pa
end
