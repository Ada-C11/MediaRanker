require "test_helper"

describe WorksController do
  before do
    @movie = Work.create!(category: "movie",
                          title: "Test Item",
                          creator: "me",
                          pub_year: 2005,
                          description: "it's a thing")
  end

  describe "index" do
    it "can get the index page" do
      get works_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid work's page" do
      get work_path(@movie.id)

      must_respond_with :success
    end

    it "will redirect for an invalid work id" do
      get work_path(-1)

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end

  describe "new" do
    it "can get the page for a new work form" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new work" do
      work_hash = {
        work: {
          category: "book",
          title: "Dictionary",
          creator: "The world",
          pub_year: "1950",
          description: "All the words",
        },
      }

      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      dictionary = Work.find_by(title: work_hash[:work][:title])
      expect(dictionary.description).must_equal work_hash[:work][:description]

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end

  describe "edit" do
    it "can get the edit page for an existing work" do
      get edit_work_path(@movie.id)

      must_respond_with :success
    end

    it "will respond with redirect when given an invalid id" do
      get edit_work_path(199999)

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end

  describe "update" do
    it "can update an existing work" do
      test_work = @movie

      work_details = {
        work: {
          category: "album",
        },
      }

      expect {
        patch work_path(test_work), params: work_details
      }.wont_change "Work.count"

      must_respond_with :redirect
      must_redirect_to work_path(test_work.id)

      test_work.reload
      expect(test_work.category).must_equal(work_details[:work][:category])
    end
  end

  describe "destroy" do
    it "removes the work from the database" do
      album = Work.create!(category: "album", title: "wow")

      expect {
        delete work_path(album.id)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path

      after_album = Work.find_by(id: album.id)
      expect(after_album).must_be_nil
    end
  end
end
