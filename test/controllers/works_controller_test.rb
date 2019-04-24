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

  # describe "update" do
  #   # nominal: it should update a book and redirect to the book show page
  #   it "will update an existing book" do
  #     # Arrange
  #     starter_input = {
  #       title: "Becoming",
  #       author_id: Author.create(name: "Michelle Obama").id,
  #       description: "A book by the 1st lady",
  #     }

  #     book_to_update = Book.create(starter_input)

  #     input_title = "101 Bottles of OOP" # Valid Title
  #     input_author = "Sandi Metz"
  #     input_description = "A look at how to design object-oriented systems"
  #     test_input = {
  #       "book": {
  #         title: input_title,
  #         author_id: Author.create(name: input_author).id,
  #         description: input_description,
  #       },
  #     }

  #     # Act
  #     expect {
  #       patch book_path(book_to_update.id), params: test_input
  #     }.wont_change "Book.count"
  #     # .must_change "Book.count", 0

  #     # Assert
  #     must_respond_with :redirect
  #     book_to_update.reload
  #     expect(book_to_update.title).must_equal test_input[:book][:title]
  #     expect(book_to_update.author.name).must_equal Author.find(test_input[:book][:author_id]).name
  #     expect(book_to_update.description).must_equal test_input[:book][:description]
  #   end

  #   it "will return a bad_request (400) when asked to update with invalid data" do

  #     # Arrange
  #     starter_input = {
  #       title: "Becoming",
  #       author_id: Author.create(name: "Michelle Obama").id,
  #       description: "A book by the 1st lady",
  #     }

  #     book_to_update = Book.create(starter_input)

  #     input_title = "" # Invalid Title
  #     input_author = "Sandi Metz"
  #     input_description = "A look at how to design object-oriented systems"
  #     test_input = {
  #       "book": {
  #         title: input_title,
  #         author_id: Author.create(name: input_author).id,
  #         description: input_description,
  #       },
  #     }

  #     # Act
  #     expect {
  #       patch book_path(book_to_update.id), params: test_input
  #     }.wont_change "Book.count"
  #     # .must_change "Book.count", 0

  #     # Assert
  #     must_respond_with :bad_request
  #     book_to_update.reload
  #     expect(book_to_update.title).must_equal starter_input[:title]
  #     expect(book_to_update.author.name).must_equal Author.find(starter_input[:author_id]).name
  #     expect(book_to_update.description).must_equal starter_input[:description]
  #   end

  #   # edge case: it should render a 404 if the book was not found
  # end

  # describe "destroy" do
  #   it "returns a 404 if the book is not found" do
  #     invalid_id = "NOT A VALID ID"

  #     # Act
  #     # Try to do the Books#destroy action

  #     # Assert
  #     # Should respond with not found
  #     # The count will change by 0, i.e. won't change

  #   end

  #   it "can delete a book" do
  #     # Arrange - Create a book
  #     new_book = Book.create(title: "The Martian", author_id: Author.create(name: "Someone").id)

  #     expect {

  #       # Act
  #       delete book_path(new_book.id)

  #       # Assert
  #     }.must_change "Book.count", -1

  #     must_respond_with :redirect
  #     must_redirect_to books_path
  #   end
  # end
end
