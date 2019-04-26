require "test_helper"

describe Work do
  let(:work) {
    Work.new(title: "valid title",
             creator: "Sophie",
             publication_year: 1987,
             category: "movie",
             description: "just some random movie")
  }

  let(:user) {
    User.create(username: "test_username",
                joined_date: Date.today)
  }
  describe "validations" do
    it "must be valid" do
      valid_work = work.valid?
      expect(valid_work).must_equal true
    end

    it "requires a title" do
      work.title = nil
      valid_work = work.valid?
      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires a category" do
      work.category = nil
      valid_work = work.valid?
      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category].must_equal ["can't be blank"])
    end
  end

  describe "relationships" do
    it "can have 0 votes" do
      votes = work.votes
      expect(votes.length).must_equal 0
    end

    it "can have 1 or more votes by shoveling a vote into work.votes" do
      vote = Vote.create(date: Date.today,
                         work_id: Work.first,
                         user_id: User.first)
      work.votes << vote
      work.save

      expect(work.votes).must_include vote
      expect(work.votes.first).must_be_instance_of Vote
    end
  end
end
