require "test_helper"

describe Work do

  describe "validations" do
    before do
      user = User.new(username: "john")
      work = works(:idaho)
      work.user_id = 1
    end

    it "passes validations with good data" do
      result = work.valid?

      expect(result).must_equal true
    end
  end
end
