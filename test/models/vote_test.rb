require "test_helper"

describe Vote do
  let(:vote) { votes(:vote_one) }
  let(:user) { users(:one) }
  let(:work) { works(:one) }

  it "must be valid" do
    value(vote).must_be :valid?
  end

  it "has all required fields" do
    fields = [:date, :work, :user]

    fields.each do |field|
      expect(vote).must_respond_to field
    end
  end

  describe "relationships" do
    it "belongs to a user" do
      user = vote.user
      expect(vote).must_be_instance_of Vote
      expect(user).must_be_instance_of User
    end

    it "can set a user" do
      vote.update(user: dan)
      expect(vote).must_be_instance_of Vote
      expect(vote.user).must_equal "laneia"
      expect(vote.valid?).must_equal true
    end

    it "belongs to a work" do
      work = vote.work
      expect(vote).must_be_instance_of Vote
      expect(work).must_be_instance_of Work
    end

    it "can set a work" do
      vote.update(work: two)
      expect(vote).must_be_instance_of Vote
      expect(vote.work).must_equal "Sabriel"
      expect(vote.valid?).must_equal true
    end
  end

  describe "validations" do
    it "must have a user" do
      vote.user = nil
      valid = vote.valid?
      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :user
      expect(vote.errors.messages[:user]).must_equal ["must exist", "can't be blank"]

      vote.user = users(:one)
      valid = vote.valid?
      expect(valid).must_equal true
    end

    it "must have a work" do
      vote.work = nil
      valid = vote.valid?
      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :work
      expect(vote.errors.messages[:work]).must_equal ["must exist", "can't be blank"]

      vote.work = works(:one)
      valid = vote.valid?
      expect(valid).must_equal true
    end

    it "must have a date" do
      vote.date = nil
      valid = vote.valid?
      expect(valid).must_equal false
      expect(vote.errors.messages).must_include :date
      expect(vote.errors.messages[:date]).must_equal ["can't be blank"]

      vote.date = Date.today
      valid = vote.valid?
      expect(valid).must_equal true
    end
  end
end
