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
      expect(flash[:warning]).must_equal "A problem occurred: Media not found"
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
      expect(flash[:success]).must_equal "Successfully created #{new_work.title} #{new_work.category}!"
    end

    it "will respond with bad request when asked to update with invalid data" do
      work_hash = {
        work: {
          category: "book",
          title: "",
          creator: "Sandi Metz",
          publication_year: 2004,
          description: "Holy RUBY!",
        },
      }

      expect {
        post works_path, params: work_hash
      }.wont_change "Work.count"

      must_respond_with :bad_request
      expect(flash[:warning]).must_equal "A problem occurred: Could not create #{work_hash[:work][:category]}"
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
      expect(flash[:warning]).must_equal "A problem occurred: Media not found."
    end
  end

  describe "update" do
    it "can update an existing valid work" do
      work_hash = {
        work: {
          category: "album",
          title: "Paint it Black",
          creator: "The Rolling Stones",
          publication_year: 1966,
          description: "The best song on the planet",
        },
      }

      expect {
        patch work_path(work_two.id), params: work_hash
      }.wont_change "Work.count"

      must_respond_with :redirect
      work_two.reload
      expect(work_two.category).must_equal work_hash[:work][:category]
      expect(work_two.title).must_equal work_hash[:work][:title]
      expect(work_two.creator).must_equal work_hash[:work][:creator]
      expect(work_two.publication_year).must_equal work_hash[:work][:publication_year]
      expect(work_two.description).must_equal work_hash[:work][:description]
      expect(flash[:success]).must_equal "Successfully updated #{work_hash[:work][:title]} " \
                                         "#{work_hash[:work][:category]}!"
    end

    it "will return a bad request when asked to update with invalid data" do
      starter_category = work_two.category
      starter_title = work_two.title
      starter_creator = work_two.creator
      starter_publication_year = work_two.publication_year
      starter_description = work_two.description

      update_input = {
        "work": {
          category: "",
          title: "Monty Python and the Holy Grail",
          creator: "Monty Python",
          publication_year: 1975,
          description: "The silliest movie",
        },
      }

      expect {
        patch work_path(work_two.id), params: update_input
      }.wont_change "Work.count"

      must_respond_with :bad_request
      work_two.reload
      expect(work_two.category).must_equal starter_category
      expect(work_two.title).must_equal starter_title
      expect(work_two.creator).must_equal starter_creator
      expect(work_two.publication_year).must_equal starter_publication_year
      expect(work_two.description).must_equal starter_description
      expect(flash[:warning]).must_equal "A problem occurred: Could not update #{update_input[:work][:category]}"
    end
  end

  describe "destroy" do
    it "can delete an exisiting valid work" do
      expect {
        delete work_path(work.id)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path
      expect(flash[:success]).must_equal "Succesfully destroyed #{work.category} #{work.id}"
    end

    it "redirects to the root path for a non-existant work" do
      invalid_id = -1

      expect {
        delete work_path(invalid_id)
      }.wont_change "Work.count"

      must_respond_with :redirect
      must_redirect_to root_path
      expect(flash[:failure]).must_equal "Failed to destroy media"
    end
  end
end
