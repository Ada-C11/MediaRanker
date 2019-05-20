require "test_helper"

describe Work do
  let(:work2) { works(:one) }
  let(:user) { users(:one) }
  let(:work) { 
    Work.new(category: "book", title: 'test book', creator: "author", publication_year: 2019) 
  }

  describe "validations" do
    it "must be valid with good data" do
      value(work).must_be :valid?
    end

    it "fails without a category" do
      work.category = nil

      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :category
    end

    it "fails without a title" do
      work.title = nil

      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "fails without a creator" do
      work.creator = nil

      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :creator
    end

    it "fails without a publication year" do
      work.publication_year = nil

      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it "fails if the publication year isn't an integer" do
      work.publication_year = "year"

      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end
  end

  describe "media spotlight" do
    it "can return a work that was voted most" do
      perform_vote(work_id: work2.id, user_id: user.id)

      expect(Work.media_spotlight).must_be_instance_of Work
      expect(Work.media_spotlight.id).must_equal work2.id
    end

    it "returns first work if none of the works have the most votes" do
      expect(Work.media_spotlight).must_be_instance_of Work
      expect(Work.media_spotlight.id).must_equal Work.first.id
    end
  end

  describe "top ten" do
    it "can return the work with the most votes" do
      perform_vote(work_id: work2.id, user_id: users(:two).id)
      expect(Work.top_ten("album").first.id).must_equal works(:one).id

      perform_vote(work_id: works(:three).id, user_id: users(:one).id)
      perform_vote(work_id: works(:three).id, user_id: users(:two).id)

      expect(Work.top_ten("album").first.id).must_equal works(:three).id
    end
  end
end
