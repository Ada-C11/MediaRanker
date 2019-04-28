require "test_helper"

describe Work do

  describe "validations" do
    before do
      user = User.create(username: "Test")
      @work = works(:idaho)
      @work.user_id = user.id
    end

    it "passes validations with good data" do
      result = @work.valid?

      expect(result).must_equal true
    end
  end
end
