require "test_helper"

describe Work do
  let(:work) { works(:two) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "relationships" do
    it "has many votes" do
      expect(work).must_be_instance_of Work
      expect(work.votes).must_be_instance_of Array
      expect(work.votes.first).must_be_instance_of Vote
    end
  end

  describe "validations" do
    it "must have a title" do
      work.title = nil
      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end
end
