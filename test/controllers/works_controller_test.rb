require "test_helper"

describe WorksController do
  describe "index" do
    it "can get all works" do
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should be 200 OK to show an existing work" do
      valid_work_id = Work.first.id
      get work_path(valid_work_id)
      must_respond_with :success
    end

    it "should give a flash notice when requesting a non-existing or invalid work" do
      work = Work.first
      invalid_work_id = work.id
      work.destroy

      get work_path(invalid_work_id)

      must_respond_with :redirect
      must_redirect_to works_path
      expect(flash[:error]).must_equal "Unknown media!"
    end
  end

  describe "new" do
    it "can get a new instance" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create new works and redirect" do
      test_input = {
        work: {
          title: "Charles Schwab",
          category: "book",
          publication_year: 2007,
          description: "good book",
          creator: "Charles Schwab",
        },
      }

      expect {
        post works_path, params: test_input
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: "Charles Schwab")
      expect(new_work).wont_be_nil
      expect(new_work.title).must_equal test_input[:work][:title]
      expect(new_work.category).must_equal test_input[:work][:category]
      expect(new_work.publication_year).must_equal test_input[:work][:publication_year]
      expect(new_work.description).must_equal test_input[:work][:description]
      expect(new_work.creator).must_equal test_input[:work][:creator]

      expect(flash[:success]).must_equal "Work has been successfully created!"
      must_respond_with :redirect
    end

    it "returns 400 bad request when trying to create an invalid work " do
      invalid_input = {
        work: {
          title: "",
          category: "book",
          publication_year: 2007,
          description: "good book",
          creator: "Charles Schwab",
        },
      }

      expect {
        post works_path, params: invalid_input
      }.wont_change "Work.count"

      must_respond_with :bad_request
      expect(flash[:error]).must_equal "title: can't be blank"
    end
  end

  describe "update" do
  end
end
