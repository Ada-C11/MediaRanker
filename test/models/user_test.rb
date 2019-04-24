require "test_helper"

describe User do
  let(:user) { User.new }

  describe "validations" do
    it "rejects validations with bad data" do
      expect(user.valid?).must_equal false
      expect(user.errors.messages[:username][0]).must_equal "can't be blank"
    end

    it "passes validations with good data" do
      user = users(:custom1)
      expect(user).must_be :valid?
    end
  end
end
