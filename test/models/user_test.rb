require "test_helper"

describe User do
  let(:user) { users(:user_one) }

  it "must be valid" do
    valid_user = user.valid?

    expect(valid_user).must_equal true
  end

  it "requires a username" do
    user.username = nil

    expect(user.valid?).must_equal false
    expect(user.errors.messages).must_include :username
    expect(user.errors.messages[:username]).must_equal ["can't be blank"]
  end
end
