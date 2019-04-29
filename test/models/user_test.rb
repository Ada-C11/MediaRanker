require "test_helper"

describe User do

  it "must be valid" do
    user = User.new(username: "Test")
    value(user).must_be :valid?
  end
end


describe "validations" do
  it "requires a username" do
    user = User.new(username: "Test")
    user.username = nil
    valid_user = user.valid?
    expect(valid_user).must_equal false
  end
end

