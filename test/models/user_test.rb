require "test_helper"

describe User do
  before do 
    @user = User.new(
      {
        username: "test user",
      }
    )
  end

  describe "validations" do 

    it "is valid when username is present and unique" do 
      is_valid = @user.valid?
      expect(is_valid).must_equal true
    end

    it "is invalid without a username" do 
      @user.username = nil
      expect(@user.valid?).must_equal false
    end

    it "is invalid if username is non-unique" do 
      @user.username = User.first.username

      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end 
  end

  describe "relationships" do 
    it "can add a vote through votes" do 
      skip
      vote = votes.first 
      @user.votes << vote

      expect(@user.votes).must_include vote
      expect(vote.user_id).must_equal user.id
    end
  end
end
