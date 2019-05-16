require "test_helper"

describe Vote do
  let (:vote) { Vote.new(user: users(:one), work: works(:gump)) }

  describe "validations" do
    it "is valid when it's associated with a work and a user" do
      value(vote).must_be :valid?
    end

    it "isn't valid when a work_id is missing" do
      bad_vote = Vote.new(user_id: users(:one).id)

      value(bad_vote).wont_be :valid?
    end

    it "isn't valid when a user_id is missing" do
      bad_vote = Vote.new(work_id: works(:gump).id)

      value(bad_vote).wont_be :valid?
    end
  end

  describe "relations" do
    it "belongs to a work" do
      vote.save
      expect(works(:gump).votes.count).must_equal 1
      expect(works(:gump).votes.include?(vote)).must_equal true
    end

    it "belongs to a user" do
      expect(users(:two).votes.count).must_equal 1
      expect(users(:two).votes.include?(votes(:two))).must_equal true
    end
  end

  describe "voter_name" do
    it "returns the username of the user associated with the vote" do
      expect(vote.voter_name).must_equal users(:one).username
    end

    it "raises an error if the user associated with the vote isn't found, because the vote won't be valid" do
      bad_user_vote = Vote.new(user_id: "very bad", work_id: works(:gump).id)
      expect {
        bad_user_vote.voter_name
      }.must_raise NoMethodError
    end
  end

  describe "created_date" do
    it "must return a formatted string of the date" do
      vote.save

      expect(vote.created_date).must_equal "#{vote.created_at.strftime("%B %d, %Y")}"
    end
  end
end
