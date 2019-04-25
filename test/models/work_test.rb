require "test_helper"

describe Work do
  let(:work) { works(:one) }
  it "must be valid" do
    expect(work.valid?).must_equal true
  end

  describe "validations" do
    it "requires a title" do
      work.title = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
    end
  end
end
