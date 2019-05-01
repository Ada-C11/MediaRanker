require "test_helper"

describe User do
  let(:user) { users(:jane) }

  it "user name must be valid" do
    name = users(:jane)
    valid_user = user.valid?

    expect(valid_user).must_equal true
  end

  describe "validations" do 
    it "requires a name" do
      user.name = ""

      valid_user = user.valid?

      expect(valid_user).must_equal false
      expect(user.errors.messages).must_include :name
      expect(user.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "requires a unique name" do
      duplicate_user = User.new(name: user.name)

      expect(duplicate_user.save).must_equal false

      expect(duplicate_user.errors.messages).must_include :name
      expect(duplicate_user.errors.messages[:name]).must_equal ["has already been taken"]
    end
  end

  describe "relationshps" do
    it "has many votes" do
      expect(user).must_respond_to :votes
    end
  end
end # outermost describe
