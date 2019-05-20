require "test_helper"

describe WorksController do
  describe "index" do
    it "can render" do
      get works_path

      must_respond_with :ok
    end

    it "renders even if there are zero works" do
      Work.destroy_all

      get works_path

      must_respond_with :ok
    end
  end

  describe "show" do
    it "returns a 404 status code if the work doesn't exist" do
      work_id = "FAKE ID"

      get work_path(work_id)

      must_respond_with :not_found
    end

    it "works for a Work instance that exists" do
      work = works(:one)
      
      get work_path(work)

      must_respond_with :ok
    end
  end

  describe "new" do
    it "retruns status code 200" do
      get new_work_path
      must_respond_with :ok
    end
  end

  describe "create" do
    it "creates a new work" do
      work_data = {
        work: {
          category: "book",
          title: "Piece of work",
          creator: "You",
          publication_year: 2019,
          description: "Et et expedita non aut quo."
        },
      }

      expect {
        post works_path, params: work_data
      }.must_change "Work.count", +1

      work = Work.last

      must_respond_with :redirect
      must_redirect_to work_path(work.id)

      check_flash

      expect(work.title).must_equal work_data[:work][:title]
      expect(work.creator).must_equal work_data[:work][:creator]
    end

    it "sends back bad_request if no work data is sent" do
      work_data = {
        work: {
          category: ""
        },
      }
      expect(Work.new(work_data[:work])).wont_be :valid?

      expect {
        post works_path, params: work_data
      }.wont_change "Work.count"

      must_respond_with :bad_request

      check_flash(:error)
    end
  end

  describe "edit" do
    it "responds with OK for an existing work" do
      get edit_work_path(works(:one))
      must_respond_with :ok
    end

    it "responds with NOT FOUND for a fake book" do
      work_id = Work.last.id + 1
      get edit_work_path(work_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    let(:work_data) {
      {
        work: {
          title: "changed",
        },
      }
    }
    it "changes the data on the model" do
      work = works(:one)

      work.assign_attributes(work_data[:work])
      expect(work).must_be :valid?
      work.reload

      patch work_path(work), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(work)

      work.reload
      expect(work.title).must_equal(work_data[:work][:title])
    end

    it "responds with NOT FOUND for a fake book" do
      work_id = Work.last.id + 1
      patch work_path(work_id), params: work_data
      must_respond_with :not_found
    end

    it "responds with BAD REQUEST for bad data" do
      work_data[:work][:title] = ""
      work = works(:one)
      
      work.assign_attributes(work_data[:work])
      expect(work).wont_be :valid?
      work.reload

      patch work_path(work), params: work_data

      must_respond_with :bad_request
    end
  end

  # describe "destroy" do
  #   it "removes the book from the database" do
  #     # Act
  #     expect {
  #       delete book_path(@book)
  #     }.must_change "Book.count", -1

  #     # Assert
  #     must_respond_with :redirect
  #     must_redirect_to books_path

  #     after_book = Book.find_by(id: @book.id)
  #     expect(after_book).must_be_nil
  #   end

  #   it "returns a 404 if the book does not exist" do
  #     # Arrange
  #     book_id = 123456

  #     # Assumptions
  #     expect(Book.find_by(id: book_id)).must_be_nil

  #     # Act
  #     expect {
  #       delete book_path(book_id)
  #     }.wont_change "Book.count"

  #     # Assert
  #     must_respond_with :not_found
  #   end
  # end
end
