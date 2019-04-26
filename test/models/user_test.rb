require "test_helper"

describe User do
  # let(:user) { User.new }

  before do
    @user = User.new(
      username: "some user",
    )
  end

  it "passes validations with good data" do
    expect(@user).must_be :valid?
  end

  # it "must be valid" do
  #   value(user).must_be :valid?
  # end
end
