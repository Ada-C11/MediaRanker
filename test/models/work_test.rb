require "test_helper"

describe Work do
  let(:work) { Work.new(title: "Test Book") }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "validations" do
    it "passes validations with good data" do
      expect(work).must_be :valid?
    end
  end

  describe "relations" do
    #code
  end

  describe "top_ten" do
    it "returns an ordered array with top ten" do
      #code
    end

    it "returns an empty array if no works" do
      #code
    end
  end

  describe "featured" do
    it "returns the work with the most votes" do
      #code
    end

    it "returns nil if no works" do
      #code
    end
  end
end
