require "test_helper"

describe Work do
  let(:work) { Work.new }

  describe "validations" do
    it "rejects validations with bad data" do
      work
      expect(work.valid?).must_equal false
      expect(work.errors.messages[:title][0]).must_equal "can't be blank"
      expect(work.errors.messages[:category][0]).must_equal "can't be blank"
    end

    it "passes validations with good data" do
      work = works(:custom1)
      expect(work).must_be :valid?
    end
  end
end
