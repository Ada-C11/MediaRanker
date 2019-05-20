require "test_helper"

describe User do
  let(:user) { User.new(username: "new_user") }

  it "must be valid with good data" do
    value(user).must_be :valid?
  end

  it "fails without a username" do
    user.username = nil

    result = user.valid?

    expect(result).must_equal false
    expect(user.errors.messages).must_include :username
  end
end
