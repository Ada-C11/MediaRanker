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

  describe "sort_by_votes" do
    it "can sort the works by the number of votes descending" do

      # 3 votes for work three
      Vote.upvote(date: Date.today, user_id: users(:one).id, work_id: works(:three).id)
      Vote.upvote(date: Date.today, user_id: users(:two).id, work_id: works(:three).id)
      Vote.upvote(date: Date.today, user_id: users(:three).id, work_id: works(:three).id)

      # 2 votes for work one
      Vote.upvote(date: Date.today, user_id: users(:one).id, work_id: works(:one).id)
      Vote.upvote(date: Date.today, user_id: users(:two).id, work_id: works(:one).id)

      # 1 vote for work two
      Vote.upvote(date: Date.today, user_id: users(:one).id, work_id: works(:two).id)

      works = Work.sort_by_votes

      expect(works[0]).must_equal works(:three)
      expect(works[1]).must_equal works(:one)
      expect(works[2]).must_equal works(:two)
    end

    it "returns an empty array if there is no work" do
      all_works = Work.all
      all_works.length.times do |index|
        all_works[index].delete
      end

      sorted_works = Work.sort_by_votes

      expect(sorted_works).must_equal []
    end

    it "returns all works if there is no vote" do
      all_votes = Vote.all
      all_votes.length.times do |index|
        all_votes[index].delete
      end

      expect(Work.sort_by_votes).must_equal Work.all
    end
  end

  describe "spotlight" do
    it "can get the work with the highest number of votes" do

      # 3 votes for work three
      Vote.upvote(date: Date.today, user_id: users(:one).id, work_id: works(:three).id)
      Vote.upvote(date: Date.today, user_id: users(:two).id, work_id: works(:three).id)
      Vote.upvote(date: Date.today, user_id: users(:three).id, work_id: works(:three).id)

      # 2 votes for work one
      Vote.upvote(date: Date.today, user_id: users(:one).id, work_id: works(:one).id)
      Vote.upvote(date: Date.today, user_id: users(:two).id, work_id: works(:one).id)

      # 1 vote for work two
      Vote.upvote(date: Date.today, user_id: users(:one).id, work_id: works(:two).id)

      expect(Work.spotlight).must_equal works(:three)
    end

    it "returns nil if there is no work" do
      all_works = Work.all
      all_works.length.times do |index|
        all_works[index].delete
      end

      expect(Work.spotlight).must_equal nil
    end

    it "returns nil if there is no vote" do
      all_votes = Vote.all
      all_votes.length.times do |index|
        all_votes[index].delete
      end

      expect(Work.spotlight).must_equal nil
    end
  end
end
