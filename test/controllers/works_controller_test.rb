require "test_helper"

describe WorksController do
  let (:work) {
    Work.create(title: "Test Title",
                creator: "Test Creator",
                category: "Book",
                description: "The story of a developer making sure her code works",
                pub_yr: 2019)
  }

  describe "root" do
    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end

    it "displays the root page even if there are no works" do
      # Arrange
      Work.destroy_all

      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  describe "index" do
    it "can get the index path" do
      # Act
      get works_path

      # Assert
      must_respond_with :success
    end

    it "displays the index even if there are no works" do
      # Arrange
      Work.destroy_all

      # Act
      get works_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid work" do
      # Act
      get work_path(work.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid work" do
      # Act
      get work_path(-1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find work with id: -1"
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

      new_work = Work.find_by(title: work_hash[:work][:title])

      expect(new_work.description).must_equal work_hash[:work][:description]
      expect(new_work.creator).must_equal work_hash[:work][:creator]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
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
      get edit_work_path(-1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find work with id: -1"
    end
  end

  describe "update" do
    it "can update an existing work" do
      # Arrange
      test_work = work
      work_hash = {
        work: {
          title: "Test Title Two",
          creator: "Test Creator Three",
          category: "Movie",
          description: "The story of a developer making triple sure her code still works",
          pub_yr: 2019,
        },
      }

      expect {
        patch work_path(test_work.id), params: work_hash
      }.wont_change "Work.count"

      test_work.reload

      expect(test_work.description).must_equal work_hash[:work][:description]

      must_respond_with :redirect
      must_redirect_to work_path(test_work.id)
    end

    it "will redirect to the root page if given an invalid id" do
      # Act
      patch work_path(-1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find work with id: -1"

      must_redirect_to root_path
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
