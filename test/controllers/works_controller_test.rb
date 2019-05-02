require "test_helper"

describe WorksController do
  let (:work) { works(:one) }

  describe "index" do
    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end

    it "can get to the index path" do
      get works_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid work" do
      work = works(:one)
      # Act
      get work_path(work.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid work" do
      # Act
      work_id = "fake"
      get work_path(work_id)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new work page" do

      # Act
      get new_work_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new work" do

      # Arrange
      work_hash = {
        work: {
          title: "Test Title Two",
          creator: "Test Creator Two",
          category: "Album",
          description: "The story of a developer making sure her code still works",
          pub_yr: 2019,
        },
      }

      # Act-Assert
      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      check_flash

      new_work = Work.find_by(title: work_hash[:work][:title])

      expect(new_work.description).must_equal work_hash[:work][:description]
      expect(new_work.creator).must_equal work_hash[:work][:creator]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end

    it "doesn't create new work without required data" do
      work_info = {
        work: {
          title: "",
        },
      }

      expect(Work.new(work_info[:work])).wont_be :valid?

      expect {
        post works_path, params: work_info
      }.wont_change "Work.count"

      must_respond_with :bad_request

      check_flash(:warning)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing work" do
      # Act
      get edit_work_path(work.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a work that doesn't exist" do
      # Act
      work_id = "fake"
      get edit_work_path(work_id)

      # Assert
      must_redirect_to work_path
    end
  end

  describe "update" do
    let(:work_info) {
      {
        work: {
          title: "Test Title Two",
          creator: "Test Creator Three",
          category: "Movie",
          description: "The story of a developer making triple sure her code still works",
          pub_yr: 2019,
        },
      }
    }

    it "updates the data on the model" do
      work.assign_attributes(work_info[:work])
      expect(work).must_be :valid?
      work.reload

      patch work_path(work), params: work_info

      must_respond_with :redirect
      must_redirect_to work_path(work)

      work.reload
      expect(work.title).must_equal(work_info[:work][:title])
    end

    it "responds with not_found if given an invalid id" do
      work_id = "fake"

      patch work_path(work_id), params: work_info

      must_respond_with :redirect
    end

    it "does not update for bad input data" do
      work_info = {
        work: {
          category: "",
        },
      }

      patch work_path(works(:two)), params: work_info
      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "removes the test from the database" do
      # Arrange
      test_id = Work.last.id

      # Act
      expect {
        delete work_path(test_id)
      }.must_change "Work.count", -1

      # Assert
      expect(Work.find_by(id: test_id)).must_equal nil

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "redirects to root if the book does not exist" do
      # Arrange
      test_id = -1

      # Act
      delete work_path(test_id)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find work with id: -1"

      must_redirect_to root_path
    end
  end
end
