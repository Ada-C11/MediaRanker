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

  it "can have votes" do
    user = users(:al)

    expect(user.votes.length).must_equal 2
  end
end
