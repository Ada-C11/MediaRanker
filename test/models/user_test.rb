require "test_helper"

describe User do
  let(:user) { users(:one) }

  it "must be valid" do
    value(user).must_be :valid?
  end

  it "must require a username" do
    user.username = ""

    expect(user.valid?).must_equal false
    expect(user.errors.messages).must_include :username
  end

  describe "relationships" do
    it "can have many votes" do
      expect(user.votes.count).must_be :>=, 0
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
