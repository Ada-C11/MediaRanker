require "test_helper"

describe Work do
  describe "validations" do
    let(:work) { works(:one) }

    it "must be valid" do
      value(work).must_be :valid?
    end

    it "requires a title" do
      work.title = nil
      valid_work = work.valid?
      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires specific categories" do
      wrong_category = Work.new(title: "Hello", category: "record")
      expect(wrong_category.save).must_equal false
      expect(wrong_category.errors.messages).must_include :category
      expect(wrong_category.errors.messages[:category]).must_equal ["is not included in the list"]
    end
  end

  describe "relationships" do
    let(:work) { works(:one) }
    let(:work2) { works(:two) }

    it "can have 0 votes" do
      expect(work2.votes.count).must_equal 0
    end

    it "can have many votes" do
      expect(work.votes.length).must_equal 11
    end
  end
end
