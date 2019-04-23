require "test_helper"

describe WorksController do
  let(:work) { works(:war_and_peace) }

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
      category = "book"
      title = "Fresh and Clean"
      creator = "That One Guy"
      publication_year = 1920
      description = "Hey There Fancy Pants knock off!"

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
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: title)
      expect(new_work.category).must_equal(category)
      expect(new_work.creator).must_equal(creator)
      expect(new_work.publication_year).must_equal(publication_year)
      expect(new_work.description).must_equal(description)

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end

    it "will return a 400 with an invalid book" do
      category = ""
      title = "Sandi Metz"
      creator = "A look at how to design object-oriented systems"
      publication_year = 2004
      description = "Holy Ruby HEAVEN!"

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
  end

  describe "update" do
    it "can update an existing valid work" do
    end
  end

  describe "delete" do
    it "can delete an exisiting valid work" do
    end
  end
end
