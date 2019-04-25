require "test_helper"

describe User do
  let(:user) { User.new(username: "username") }

  it "must be valid" do
    value(user).must_be :valid?
  end
end
