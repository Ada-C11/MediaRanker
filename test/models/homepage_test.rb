require "test_helper"

describe Homepage do
  let(:homepage) { Homepage.new }

  it "must be valid" do
    value(homepage).must_be :valid?
  end

  describe "self.top_media" do
    it "returns object of media with the most votes" do
    end
  end

  describe "self.top_ten" do
    it "returns an array of ten objects" do
    end

    it "returns the 10 objects of given type with most votes" do
    end
  end
end
