require "test_helper"

describe User do
  let(:user) { users(:two)}

  it "must be valid" do
    is_valid = user.valid?
    value(is_valid).must_equal true
  end

  it "checks if username is valid" do
    user_name = user.username
    
    expect(user).must_be :valid?
    expect(user.username).must_equal user_name

  end

  it "can't create a new user without a username" do
    user = User.new
    user.username = ""
    failed_user = user.save

    expect(failed_user).must_equal false
  end
end
