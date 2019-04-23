require "test_helper"

describe WorksController do
  describe "index" do
    it "can get index" do
      # Act
      get works_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid work" do

      # Act
      get work_path(one.id)

      # Assert
      must_respond_with :success
    end
    it "will redirect for an invalid passenger" do

      # Act
      get passenger_path(-1)

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

  it "should get create" do
    get works_create_url
    value(response).must_be :success?
  end

  describe "create" do
    it "can create a new work" do

      # Arrange
      work_hash = {
        work: {
          title: "Test Work",
          description: "New work description",
          publication_year: 2000,
          creator: "Test Creator",
          category: "movie",
        },
      }

      # Act-Assert
      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      new_work = Task.find_by(title: work_hash[:work][:title])
      expect(new_task.description).must_equal task_hash[:task][:description]

      must_respond_with :redirect
      must_redirect_to work_path(new_task.id)
    end
  end

  it "should get edit" do
    get works_edit_url
    value(response).must_be :success?
  end

  it "should get update" do
    get works_update_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get works_destroy_url
    value(response).must_be :success?
  end
end
