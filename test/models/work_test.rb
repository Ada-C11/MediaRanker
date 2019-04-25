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

  describe "self.get_media_catagories" do
    it "returns an array of length 3" do
      media = Work.get_media_catagories

      expect(media).must_be_instance_of Array

      expect(media.length).must_equal 3
    end
  end

  describe "self.top_media" do
  end

  describe "self.spotlight" do
  end
end
