require "test_helper"

describe User do
  let(:user) { users(:first_user) }
    
  describe "user model validations" do 
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

    it "validates for unique usernames" do 
      user = User.first
      next_user = User.new
      next_user.username = user.username
      result = next_user.save

      expect(result).must_equal false
    end
  end

  describe "user instatiation" do 
    it "can be instantiated" do 
      new_user = User.new(username: "New person")
      expect(new_user.valid?).must_equal true
    end

    it "responds to all fields" do 
      expect(user).must_respond_to :username
    end
  end

  describe "relationships" do 
    it "has zero to many upvotes or works" do 

      expect(user).must_respond_to :upvotes
      expect(user.upvotes.count).must_be :>=, 0
      expect(user).must_respond_to :works
      expect(user.works.count).must_be :>=, 0
    end
  end
end
