require "test_helper"

describe User do
  let(:user) { users(:first_user) }
    
  it "validates for username" do
    name = user.username

    expect(user).must_be :valid?
    expect(user.username).must_equal name
  end

  it "doesn't create a user without a name" do 
    user = User.new
    user.username = ""
    result = user.save

    expect(result).must_equal false
  end

  it "won't allow another user in with the same name" do 
    user = User.new
    user.username = "First Name"
    result = user.save

    expect(result).must_equal false
  end
end
