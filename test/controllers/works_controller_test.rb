require "test_helper"

describe WorksController do
  describe "index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should be OK to show an existing, valid work" do
      valid_work_id = works(:one).id
      get work_path(valid_work_id)
      must_respond_with :success
    end

    it "should give a flash notice instead of showing a non-existant, invalid work" do
      work = works(:two)
      invalid_work_id = work.id
      work.destroy
      get work_path(invalid_work_id)
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown work"
    end
  end

  describe "create" do
    it "will save a new work and redirect if given valid inputs" do
      input_title = "Normal People"
      input_creator = "Sally Rooney"
      input_description = "Millenial Romance"
      input_category = "book"
      test_input = {
        "work": {
          title: input_title,
          creator: input_creator,
          description: input_description,
          category: input_category,
        },
      }

      # Act
      expect {
        post works_path, params: test_input
      }.must_change "Work.count", 1

      # Assert
      new_work = Work.find_by(title: input_title)
      expect(new_work).wont_be_nil
      expect(new_work.title).must_equal input_title
      expect(new_work.creator).must_equal input_creator
      expect(new_work.category).must_equal input_category

      must_respond_with :redirect
    end

    it "will return a 400 with an invalid work" do
      input_title = ""
      input_creator = "Sally Rooney"
      input_description = "Millenial Romance"
      input_category = "book"
      test_input = {
        "work": {
          title: input_title,
          creator: input_creator,
          description: input_description,
          category: input_category,
        },
      }
      expect {
        post works_path, params: test_input
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end
  end

  describe "update" do
    it "will update an existing work" do
      work = works(:two)

      input_title = "Home Coming"
      input_creator = "Yonce"
      input_description = "Amazing"
      test_input = {
        "work": {
          title: input_title,
          creator: input_creator,
          description: input_description,
          category: work.category,
          publication_year: work.publication_year,
        },
      }

      expect {
        patch work_path(work.id), params: test_input
      }.wont_change "Work.count"

      must_respond_with :redirect
      work.reload
      expect(work.title).must_equal test_input[:work][:title]
      expect(work.creator).must_equal test_input[:work][:creator]
      expect(work.description).must_equal test_input[:work][:description]
    end

    it "will return a bad_request (400) when asked to update work with invalid data" do
      starter_input = works(:two)
      work_to_update = works(:two)

      input_title = ""
      test_input = {
        "work": {
          title: input_title,
          creator: work_to_update.creator,
          description: work_to_update.description,
          category: work_to_update.category,
          publication_year: work_to_update.publication_year,
        },
      }

      expect {
        patch work_path(work_to_update.id), params: test_input
      }.wont_change "Work.count"
      must_respond_with :bad_request
      work_to_update.reload
      expect(work_to_update.title).must_equal starter_input.title
      expect(work_to_update.creator).must_equal starter_input.creator
      expect(work_to_update.description).must_equal starter_input.description
    end
  end

  describe "destroy" do
    it "returns a 404 if the work is not valid" do
      invalid_work_id = -1

      get work_path(invalid_work_id)
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown work"
    end

    it "can delete a work" do
      new_work = works(:one)

      expect {
        delete work_path(new_work.id)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end
end
