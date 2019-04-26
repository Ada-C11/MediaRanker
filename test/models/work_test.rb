require "test_helper"

describe Work do
  let(:work) { works(:one) }
  let(:vote_one) { votes(:one) }
  let(:vote_two) { votes(:two) }

  it "must be valid" do
    expect(work.valid?).must_equal true
  end

  describe "validations" do
    it "requires a title" do
      work.title = nil
      valid_work = work.valid?
      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires a unique title" do
      dup_work = Work.new(title: work.title)
      expect(dup_work.save).must_equal false
      expect(dup_work.errors.messages).must_include :title
      expect(dup_work.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
    it "has many votes" do
      work.votes << vote_one
      work.votes << vote_two
      expect(work.votes.first).must_equal vote_one
      expect(work.votes.last).must_equal vote_two
    end
  end

  describe "custom methods" do
  end
end
