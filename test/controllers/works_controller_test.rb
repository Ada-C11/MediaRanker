require "test_helper"

describe WorksController do
  let(:work) { works(:war_and_peace) }
  let(:work_two) { works(:spaghetti) }

  describe "index" do
    it "can get index" do
      get works_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can show an existing valid work" do
      get work_path(work.id)

      must_respond_with :success
    end

    it "will redirect to root path if given an invalid work id" do
      invalid_id = -5

      get work_path(invalid_id)
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "new" do
    it "can get the new page" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new work" do
      work_hash = {
        "work": {
          category: "book",
          title: "Fresh and Clean",
          creator: "That One Guy",
          publication_year: 1920,
          description: "Hey There Fancy Pants knock off!",
        },
      }

      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: work_hash[:work][:title])
      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.publication_year).must_equal work_hash[:work][:publication_year]
      expect(new_work.description).must_equal work_hash[:work][:description]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end

    it "will respond with bad request when asked to update with invalid data" do
      work_hash = {
        "work": {
          category: "",
          title: "99 Bottles of OOP",
          creator: "Sandi Metz",
          publication_year: 2004,
          description: "Holy RUBY!",
        },
      }

      expect {
        post works_path, params: work_hash
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "can edit an existing valid work" do
      get edit_work_path(work.id)

      must_respond_with :success
    end

    it "will redirect to root path if given an invalid work id" do
      invalid_id = -10

      get edit_work_path(invalid_id)

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "update" do
    it "can update an existing valid work" do
      category = "book"
      title = "101 Bottles of OOP"
      creator = "Sandi Metz"
      publication_year = 2006
      description = "A look at how to design object-oriented systems"
      work_hash = {
        "work": {
          category: category,
          title: title,
          creator: creator,
          publication_year: publication_year,
          description: description,
        },
      }

      expect {
        patch work_path(work_two.id), params: work_hash
      }.wont_change "Work.count"

      must_respond_with :redirect
      # work_two.reload
      expect(work_two.category).must_equal work_hash[:work][:category]
      expect(work_two.title).must_equal work_hash[:work][:title]
      expect(work_two.creator).must_equal work_hash[:work][:creator]
      expect(work_two.publication_year).must_equal work_hash[:work][:publication_year]
      expect(work_two.description).must_equal work_hash[:work][:description]
    end

    it "will return a bad_request (400) when asked to update with invalid data" do

      # Arrange
      starter_input = {
        title: "Becoming",
        author_id: Author.create(name: "Michelle Obama").id,
        description: "A book by the 1st lady",
      }

      book_to_update = Book.create(starter_input)

      input_title = "" # Invalid Title
      input_author = "Sandi Metz"
      input_description = "A look at how to design object-oriented systems"
      test_input = {
        "book": {
          title: input_title,
          author_id: Author.create(name: input_author).id,
          description: input_description,
        },
      }

      # Act
      expect {
        patch book_path(book_to_update.id), params: test_input
      }.wont_change "Book.count"
      # .must_change "Book.count", 0

      # Assert
      must_respond_with :bad_request
      book_to_update.reload
      expect(book_to_update.title).must_equal starter_input[:title]
      expect(book_to_update.author.name).must_equal Author.find(starter_input[:author_id]).name
      expect(book_to_update.description).must_equal starter_input[:description]
    end
  end

  describe "delete" do
    it "can delete an exisiting valid work" do
    end
  end
end
