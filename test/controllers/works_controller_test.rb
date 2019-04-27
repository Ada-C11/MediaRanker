require "test_helper"

describe WorksController do
  it "should get index" do
    get works_path
    must_respond_with :success
  end

  describe "show" do
    it "should be OK to show an existing, valid work" do
      valid_work_id = works(:one).id
      get work_path(valid_work_id)

      must_respond_with :success
    end

    it "should flash instead of showing a non-existant, invalid book" do
      work = works(:one)
      invalid_work_id = work.id
      work.destroy

      get work_path(invalid_work_id)
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown work!"
    end
  end

  describe "create" do
    it "will save a new work and redirect if given valid input" do
      test_input = {
        work: {
          category: "movie",
          title: "test movie",
          creator: "test angela",
          publication_year: 1999,
          description: "test description",
        },
      }

      expect {
        post works_path, params: test_input
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: test_input[:work][:title])
      expect(new_work).wont_be_nil
      expect(new_work.title).must_equal test_input[:work][:title]
      expect(new_work.category).must_equal test_input[:work][:category]
      expect(new_work.creator).must_equal test_input[:work][:creator]
      expect(new_work.publication_year).must_equal test_input[:work][:publication_year]
      expect(new_work.description).must_equal test_input[:work][:description]
      expect(flash[:success]).must_equal "Work added successfully!"
    end

    it "should flash and return a 400 witha an invalid work" do
      test_input = {
        work: {
          category: "movie",
          title: "",
          creator: "test angela",
          publication_year: 1999,
          description: "test description",
        },
      }

      expect {
        post works_path, params: test_input
      }.wont_change "Work.count"
      expect(flash[:title]).must_equal ["can't be blank"]
      must_respond_with :bad_request
    end
  end

  describe "update" do
    it "will update an existing work" do
      work_to_update = works(:one)

      updates = {
        work: {
          title: "changed title",
        },
      }

      expect {
        patch work_path(work_to_update.id), params: updates
      }.wont_change "Work.count"
      must_respond_with :redirect
      work_to_update.reload
      expect(work_to_update.title).must_equal "changed title"
      expect(flash[:success]).must_equal "Work updated successfully!"
    end

    it "should flash and return a 400 with an invalid updates" do
      work_to_update = works(:one)

      updates = {
        work: {
          title: "",
        },
      }

      expect {
        patch work_path(work_to_update.id), params: updates
      }.wont_change "Work.count"
      must_respond_with :bad_request
      expect(work_to_update.title).wont_equal ""
      expect(flash[:title]).must_equal ["can't be blank"]
    end
  end

  describe "destroy" do
    it "shows a flash message if work is not found" do
      invalid_id = "NOT A VALID ID"
      expect {
        delete work_path(invalid_id)
      }.wont_change "Work.count"
      expect(flash[:error]).must_equal "Work already does not exist."
      must_respond_with :redirect
    end

    it "can delete a work" do
      delete_work = works(:two)
      expect {
        delete work_path(delete_work.id)
      }.must_change "Work.count", -1
      must_redirect_to works_path
    end
  end

  describe "vote" do
    it "allows a user to make a vote" do
      perform_login
      voting_work = Work.create(category: "book", title: "test book", creator: "me", vote_count: 0)

      expect {
        post vote_path(voting_work.id)
      }.must_change "Vote.count", 1

      expect(flash[:success]).must_equal "Work updated successfully!"
    end

    it "allows a user vote on multiple works" do
      perform_login
      voting_work_one = Work.create(category: "book", title: "test book", creator: "me", vote_count: 0)
      voting_work_two = Work.create(category: "album", title: "test album", creator: "me", vote_count: 0)

      expect {
        post vote_path(voting_work_one.id)
      }.must_change "Vote.count", 1
      expect {
        post vote_path(voting_work_two.id)
      }.must_change "Vote.count", 1
      expect(flash[:success]).must_equal "Work updated successfully!"
    end

    it "does not allow users to vote on work more than once" do
      perform_login
      voting_work = Work.create(category: "book", title: "test book", creator: "me", vote_count: 0)
      post vote_path(voting_work.id)

      expect {
        post vote_path(voting_work.id)
      }.wont_change "Vote.count"
    end

    it "does not allow user to vote if not logged in" do
      voting_work = Work.create(category: "book", title: "test book", creator: "me", vote_count: 0)

      expect {
        post vote_path(voting_work.id)
      }.wont_change "Vote.count"

      expect(flash[:error]).must_equal "You must be logged in to vote!"
    end
  end
end
