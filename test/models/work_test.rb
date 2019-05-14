require "test_helper"

describe Work do
  let(:work) { works(:album) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "validations" do
    it "must have a title" do
      work.title = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a unique title" do
      identical_title = Work.new(title: "Lemonade", creator: "Beyonce")

      expect(identical_title.save).must_equal false

      expect(identical_title.errors.messages).must_include :title
      expect(identical_title.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end
end
