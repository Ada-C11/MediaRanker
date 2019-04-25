require "test_helper"

describe Work do
  let(:album) { works(:album) }

  it "must be valid" do
    expect(album.valid?).must_equal true
  end

  describe "validations" do
    it "requires a category" do
      album.category = nil

      valid_work = album.valid?

      expect(valid_work).must_equal false
      expect(album.errors.messages).must_include :category
      expect(album.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "requires a unique title" do
      duplicate_album = Work.new(category: album.category, title: album.title)

      expect(duplicate_album.save).must_equal false

      expect(duplicate_album.errors.messages).must_include :title
      expect(duplicate_album.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
  end

  describe "custom methods" do
  end
end
