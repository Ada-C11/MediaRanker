require "test_helper"

describe Work do
  let(:work) { Work.new }
  describe "Validations" do
    it "Validates with good data" do
      work.title = "A new Hope"

      result = work.valid?

      expect(result).must_equal true
    end

    it "Wont validate a work without a title" do
      result = work.valid?

      expect(result).must_equal false
    end
  end
end
