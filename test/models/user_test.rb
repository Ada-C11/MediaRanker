require "test_helper"

describe User do
  let(:user) { User.first }

  it "must be valid" do
    value(user).must_be :valid?
  end

  it "must reject a user without a username" do
    user.username = ""

    value(user).must_be :invalid?
  end
end
