require "test_helper"

describe User do
  user = User.new(username: "Beto")

  it "must be valid" do
    value(user).must_be :valid?
  end
end
