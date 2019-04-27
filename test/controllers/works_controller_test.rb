require "test_helper"

describe WorksController do
  it "get works index page" do
    get works_path
    must_respond_with :success
  end

  describe "new" do
    it "get new work page" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "save a new work and redirect if given valid inputs" do

      # Arrange
      new_work_title = "Star Wars: A New Hope"
      new_work_creator = "George Lucas"
      new_work_description = "A young Luke Skywalker is torn from his childhood home at the mysterious appearance of two robots and a wizened sorcerer, one of whom holds the secret to defeating an intergalactic empire."
      new_work_pub = "1977"

      valid_work_params = {
        work: {
          title: new_work_title,
          creator: new_work_creator,
          description: new_work_description,
          publication_year: new_work_pub,
          category: "movie",
        },
      }

      # Act
      expect {
        post works_path, params: valid_work_params
      }.must_change "Work.count", 1

      # Assert
      new_work = Work.find_by(title: new_work_title)
      expect(new_work).wont_be_nil
      expect(new_work.title).must_equal new_work_title
      expect(new_work.description).must_equal new_work_description

      must_respond_with :redirect
    end

    it "return 404 bad request for an invalid work" do
      bad_work_title = ""
      bad_work_description = "bad description, not very descriptive"
      bad_work_params = {
        work: {
          title: bad_work_title,
          description: bad_work_description,
          category: "movie",
        },
      }

      expect {
        post works_path, params: bad_work_params
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end
  end

  describe "show" do
    it "display a valid work" do
      valid_work_id = works(:readyplayerone).id
      get works_path(valid_work_id)
      must_respond_with :success
    end

    it "return a 404 not found when searching for a non-existant work" do
      get work_path(-1)
      must_redirect_to works_path
    end
  end

  describe "edit" do
    it "get the edit page for a work" do
      valid_work_id = works(:readyplayerone).id
      get edit_work_path(valid_work_id)
      must_respond_with :success
    end

    it "respond with 404 not found when loading the edit page for a nonexistant work" do
      get edit_work_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    new_params = {
      work: {
        title: "Gotta Go Slow To Go Fast",
        description: "A look into the techniques for getting faster at a skill by learning it well.",
      },
    }
    it "update an existing work" do
      work_to_update = works(:readyplayerone)
      expect {
        patch work_path(work_to_update.id), params: new_params
      }.wont_change "Work.count"

      work_to_update.reload
      expect(work_to_update.title).must_equal new_params[:work][:title]
      expect(work_to_update.description).must_equal new_params[:work][:description]
    end

    it "respond with 404 not found if updating a non-existant work" do
      # edge case: it should render a 404 if the work is not found
      # ASK MEG ABOUT THIS. CAN'T USE RENDER/REDIRECT MORE THAN ONCE IN AN ACTION.

      skip

      expect {
        patch work_path(-1), params: new_params
      }.wont_change "Work.count"

      must_respond_with :not_found
    end

    it "return a 400 bad_request when asked to update with invalid data" do

      # Arrange
      original_work = works(:endersgame)
      work_to_update = works(:endersgame)

      new_work_title = "" # invalid name
      new_work_des = "bad description here"

      bad_params = {
        "work": {
          title: new_work_title,
          description: new_work_des,
        },
      }

      # Act
      expect {
        patch work_path(work_to_update.id), params: bad_params
      }.wont_change "Work.count"

      # Assert
      must_respond_with :bad_request
      work_to_update.reload
      expect(work_to_update.title).wont_be_nil
      expect(work_to_update.description).must_equal original_work[:description]
    end
  end

  describe "destroy" do
    it "delete a work" do
      work_to_destroy = works(:endersgame)

      expect {
        delete work_path(work_to_destroy.id)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path
    end

    it "return a 404 not found error if the work is not found" do
      invalid_id = -1

      expect {
        delete work_path(invalid_id)
      }.wont_change "Work.count"
      must_redirect_to works_path
    end
  end
end
