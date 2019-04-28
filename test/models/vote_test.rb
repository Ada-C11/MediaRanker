require "test_helper"

describe Vote do
  let(:vote) { votes(:one) }

  it "must be valid" do
    value(vote).must_be :valid?
  end

  describe "top_ten" do
    it "must return the top ten works" do
    end
    it "must return an empty arry of no works" do
    end
  end

  describe "spotlight" do
    it "must return the most voted on work" do
    end

    it "must return nil if no works" do
    end
  end
end
