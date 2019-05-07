require "test_helper"

describe Work do

  describe "validations" do
    before do
      user = User.create(username: "Test")
      @work = works(:idaho)
      @work.user_id = user.id
    end

    it "passes validations with good data" do
      result = @work.valid?

      expect(result).must_equal true
    end
  end

  describe "top_ten" do
    it "returns empty array if no works in that category" do
      book = Work.find_by(category: "book")
      Work.destroy(book.id)
      no_works = Work.top_ten("book")

      expect(no_works).must_equal []
    end

    it "returns all works in the category if less than 10" do
      top_works = Work.top_ten("album")

      expect(top_works.length).must_equal Work.where(category: "album").length
    end
  end
end
