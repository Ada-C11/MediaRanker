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
    it "can show a valid work" do

      # Act
      get work_path(works(:one).id)

      # Assert
      must_respond_with :success
    end
    it "will redirect for an invalid work" do

      #Arrange
      work = works(:one)
      invalid_work_id = work.id
      work.destroy

      # Act
      get work_path(invalid_work_id)

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
    it "will save a new work if given valid input" do

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

      new_work = Work.find_by(title: work_hash[:work][:title])
      expect(new_work.title).must_equal work_hash[:work][:title]
      expect(new_work.description).must_equal work_hash[:work][:description]
      expect(new_work.publication_year).must_equal work_hash[:work][:publication_year]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.category).must_equal work_hash[:work][:category]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end

    it "will return a 400 with an invalid work" do

      # Arrange
      work_hash = {
        "work": {
          title: nil,
          description: "New work description",
          publication_year: 2000,
          creator: "Test Creator",
          category: "movie",
        },
      }

      # Act
      expect {
        post works_path, params: work_hash
      }.wont_change "Work.count"

      # Assert
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "can get the edit work page" do

      # Act
      get edit_work_path(works(:one).id)

      # Assert
      must_respond_with :success
    end
  end

  describe "update" do
    it "will update an exiting work" do
      # Arrange
      work_to_update = works(:one)

      work_hash = {
        "work": {
          title: "Updated Title",
          description: "Updated description",
          publication_year: 2001,
          creator: "Updated Creator",
          category: "movie",
        },
      }

      # Act-Assert
      expect {
        patch work_path(work_to_update.id), params: work_hash
      }.wont_change "Work.count"

      # Assert
      must_respond_with :redirect
      work_to_update.reload
      expect(work_to_update.title).must_equal work_hash[:work][:title]
      expect(work_to_update.description).must_equal work_hash[:work][:description]
      expect(work_to_update.publication_year).must_equal work_hash[:work][:publication_year]
      expect(work_to_update.creator).must_equal work_hash[:work][:creator]
      expect(work_to_update.category).must_equal work_hash[:work][:category]
    end

    it "will return a 400 when asked to update with invalid data" do
      # Arrange
      work_to_update = works(:one)

      work_hash = {
        "work": {
          title: nil,
          description: "Updated description",
          publication_year: 2001,
          creator: "Updated Creator",
          category: "movie",
        },
      }

      # Act-Assert
      expect {
        patch work_path(work_to_update.id), params: work_hash
      }.wont_change "Work.count"

      # Assert
      must_respond_with :bad_request
      # book_to_update.reload
      # expect(book_to_update.title).must_equal starter_input[:title]
      # expect(book_to_update.author.name).must_equal Author.find(starter_input[:author_id]).name
      # expect(book_to_update.description).must_equal starter_input[:description]
    end
  end

  # it "should get destroy" do
  #   get works_destroy_url
  #   value(response).must_be :success?
  # end
end
