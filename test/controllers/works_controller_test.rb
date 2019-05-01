require "test_helper"

describe WorksController do
  describe "index"do
    it "must be able to get index" do

      # Arrange - Act
      get works_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "should be OK to show a valid work" do
      # Arrange
      valid_work_id = works(:uprooted).id

      # Act
      get work_path(valid_work_id)

      # Assert
      must_respond_with :success
    end

    it "should give a flash message" do
      # Arrange
      work = works(:uprooted)
      invalid_work_id = work.id
      work.destroy

      # Act
      get work_path(invalid_work_id)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown work"  
    end
  end

  describe "new" do
    it "must be able to get new" do
      # Arrange - Act
      get new_work_path

      # Assert
      must_respond_with :success    
    end
  end

  describe "create" do
    it "will save a new work of art to the database" do

      # Arrange
      test_title = "Catching Fire"
      test_creator = "Suzanne Collins"
      test_description = "Second book of The Hunger Games"
      test_category = "book"
      test_publication_year = 2008
      test_input = {
        "work": {
          title: test_title,
          creator: test_creator,
          category: test_category,
          description: test_description,
          publication_year: test_publication_year,
        },
      }

      # Act
      expect {
        post works_path, params: test_input
      }.must_change "Work.count", 1

      # Assert
      new_work = Work.find_by(title: test_title)
      expect(new_work).wont_be_nil
      expect(new_work.title).must_equal test_title
      expect(new_work.creator).must_equal test_creator
      expect(new_work.description).must_equal test_description
      expect(new_work.category).must_equal test_category
      expect(new_work.publication_year).must_equal test_publication_year

      must_respond_with :redirect
    end

    it "will return a 400 with an invalid work" do

      # Arrange
      test_title = ""
      test_creator = "Suzanne Collins"
      test_description = "Second book of The Hunger Games"
      test_category = "book"
      test_publication_year = 2008
      test_input = {
        "work": {
          title: test_title,
          creator: test_creator,
          category: test_category,
          description: test_description,
          publication_year: test_publication_year,
        },
      }

      # Act
      expect {
        post works_path, params: test_input
      }.wont_change "Work.count"

      # Assert
      must_respond_with :bad_request
    end
  end

  describe "update" do

    it "will update an existing work" do
      # Arrange
      existing_work = {
        title: "Indiana Jones",
        creator: "Hollywood",
        description: "I really hate snakes",
        category: "movie",
        publication_year: 1982
      }

      existing_work_to_update = Work.create(existing_work)

      input_title = "Indiana Jones" # Valid Title
      input_creator = "Hollywood"
      input_description = "Harrison Ford with a hat and a whip"
      input_category = "movie",
      input_publication_year = 2019
      test_input = {
        "work": {
          title: input_title,
          creator: input_creator,
          description: input_description,
          category: input_category,
          publication_year: input_publication_year,
        },
      }

      # Act
      expect {
        patch work_path(existing_work_to_update.id), params: test_input
      }.wont_change "Work.count"

      # Assert
      must_respond_with :redirect
      existing_work_to_update.reload
      expect(existing_work_to_update.title).must_equal test_input[:work][:title]
      expect(existing_work_to_update.creator).must_equal test_input[:work][:creator]
      expect(existing_work_to_update.description).must_equal test_input[:work][:description]
      expect(existing_work_to_update.publication_year).must_equal test_input[:work][:publication_year]
    end
  end

  describe "destroy" do 
    it "can delete a work" do 
      # Arrange
      new_work = Work.create(
        title: "The Martian",
        creator: "Hollywood",
        description: "MAn gets left behind on Mars",
        category: "movie",
        publication_year: 2017
      )

      # Act - Assert
        expect{
          delete work_path(new_work.id)
        }.must_change "Work.count", -1

        must_respond_with :redirect
        must_redirect_to works_path
    end

    it "will respond with a redirect if the work of art cannot be found in the database" do
      # Arrange 
      invalid_work_id = -1

      # Act
      get work_path(invalid_work_id)

      # Assert
      must_respond_with :redirect

    end
  end
end # outermost describe
