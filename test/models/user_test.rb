require "test_helper"

describe User do
  before do 
    @user = User.first
  end 

  it "passes validations with good data" do
    expect(@user).must_be :valid?
  end

  it "rejects users with the same username" do
    # arrange
    duplicate_name = @user.username 
    user = User.new(username: duplicate_name)
    # act
    result = user.valid?

    expect(result).must_equal false
    expect(user.errors.messages).must_include :username
  end

  it "responds to votes" do
    assert_respond_to(@user, :votes)
  end
end
