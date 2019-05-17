require "test_helper"

describe WorksController do
  describe "index" do
    it "can get all works" do
      get works_path
      must_respond_with :success
    end
  end

  describe "top_media" do
    it "can get top works" do
      get root_path
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
      expect(flash[:title]).must_equal ["can't be blank"]
    end
  end

  describe "update" do
    it "will update an existing work" do
      test_work = Work.first
      input_to_edit = {
        work: {
          title: "awesome work",
          creator: "awesome creator",
          category: "awesome category",
          publication_year: 2008,
          description: "awesome description",
        },
      }

      expect {
        patch work_path(test_work), params: input_to_edit
      }.wont_change "Work.count"

      must_respond_with :redirect
      test_work.reload

      expect(flash[:success]).must_equal "Work updated successfully!"
      expect(test_work.title).must_equal input_to_edit[:work][:title]
      expect(test_work.creator).must_equal input_to_edit[:work][:creator]
      expect(test_work.category).must_equal input_to_edit[:work][:category]
      expect(test_work.publication_year).must_equal input_to_edit[:work][:publication_year]
      expect(test_work.description).must_equal input_to_edit[:work][:description]
    end

    it "will return bad request when asked to update with invalid data" do
      test_work = Work.first
      test_title = test_work.title
      test_creator = test_work.creator
      test_description = test_work.description
      test_publication_year = test_work.publication_year
      test_category = test_work.category
      input_to_edit = {
        work: {
          title: "",
          creator: "awesome creator",
          category: "",
          publication_year: 2008,
          description: "awesome description",
        },
      }

      expect {
        patch work_path(test_work.id), params: input_to_edit
      }.wont_change "Work.count"

      must_respond_with :bad_request
      test_work.reload
      expect(test_work.title).must_equal test_title
      expect(test_work.creator).must_equal test_creator
      expect(test_work.description).must_equal test_description
      expect(test_work.publication_year).must_equal test_publication_year
      expect(test_work.category).must_equal test_category
      expect(flash[:title]).must_equal ["can't be blank"]
    end
  end

  describe "destroy" do
    it "can delete the work" do
      test_work = Work.first
      test_title = test_work.title
      expect {
        delete work_path(test_work.id)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path
      expect(flash[:success]).must_equal "#{test_title} has been deleted!"
    end

    it "returns a flash error if the work does not exist " do
      expect {
        delete work_path(-1)
      }.wont_change "Work.count"

      must_respond_with :redirect
      must_redirect_to works_path
      expect(flash[:error]).must_equal "The work does not exist!"
    end
  end
end
