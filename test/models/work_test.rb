require "test_helper"

describe Work do
  let(:work) { Work.new }

  describe "Relationships" do
  end

  describe "Validations" do
    it "is valid when all fields are present" do
      expect(work).must_be :valid?
    end

    it "must have a title" do
      work.title = nil
      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "must have a unique title for the same category" do
      other_work = Work.new title: work.title, category: "book"
      other_work.save

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end

    it "can have the same title for different categories" do
      other_work = Work.new title: work.title, category: "album"
      other_work.save

      valid = other_work.valid?

      expect(valid).must_equal true
    end
  end

  describe "Custom Methods" do
  end
end
