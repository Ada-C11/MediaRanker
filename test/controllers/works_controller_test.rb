require "test_helper"

describe "WorksController" do
  before do
    @work = Work.first
  end

  describe "index" do
    it "renders without crashing" do
      get works_path
      must_respond_with :ok
    end

    it "renders even if there are zero books" do
      Work.destroy_all

      get works_path
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
      # Arrange
      work_data = {
        work: {
          title: "Becoming",
          creator: "Michelle Obama",
          description: "The memoir of the former first lady",
          category: "book",
          publication_year: 2018,
        },
      }

      # Act
      expect {
        post works_path, params: work_data
      }.must_change "Work.count", +1

      # Assert
      work = Work.last

      must_respond_with :redirect
      must_redirect_to work_path(work.id)

      check_flash

      expect(work.title).must_equal work_data[:work][:title]
      expect(work.creator).must_equal work_data[:work][:creator]
      expect(work.description).must_equal work_data[:work][:description]
      expect(work.category).must_equal work_data[:work][:category]
      expect(work.publication_year).must_equal work_data[:work][:publication_year]
    end

    it "sends back bad_request if no work data is sent" do
      work_data = {
        work: {
          title: "",
        },
      }
      expect(Work.new(work_data[:work])).wont_be :valid?

      # Act
      expect {
        post works_path, params: work_data
      }.wont_change "Work.count"

      # Assert
      must_respond_with :bad_request

      check_flash(:error)
    end
  end

  describe "show" do
    it "returns a 404 status code if the work doesn't exist" do
      work_id = -1

      get work_path(work_id)

      must_respond_with :not_found
    end

    it "works for a work that exists" do
      get work_path(@work.id)

      must_respond_with :ok
    end
  end

  describe "edit" do
    it "responds with OK for a real work" do
      get edit_work_path(@work)
      must_respond_with :ok
    end

    it "responds with NOT FOUND for a fake work" do
      work_id = Work.last.id + 1
      get edit_work_path(work_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    let (:work_data) {
      {
        work: {
          title: "Updated Title",
        },
      }
    }

    it "changes the data on the work given valid info" do
      @work.assign_attributes(work_data[:work])
      expect(@work).must_be :valid?
      @work.reload

      patch work_path(@work), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(@work)

      check_flash

      @work.reload
      expect(@work.title).must_equal(work_data[:work][:title])
    end

    it "responds with NOT FOUND for a fake work" do
      work_id = Work.last.id + 1
      patch work_path(work_id), params: work_data
      must_respond_with :not_found
    end

    it "responds with BAD REQUEST for bad data" do
      work_data[:work][:title] = ""

      # Assumptions
      @work.assign_attributes(work_data[:work])
      expect(@work).wont_be :valid?
      @work.reload

      # Act
      patch work_path(@work), params: work_data

      # Assert
      must_respond_with :bad_request

      check_flash(:error)
    end
  end

  describe "destroy" do
    it "removes the books from the database" do
      expect {
        delete work_path(@work)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path

      check_flash

      after_work = Work.find_by(id: @work.id)
      expect(after_work).must_be_nil
    end

    it "returns a 404 if the book does not exist" do
      work_id = -1

      expect(Work.find_by(id: work_id)).must_be_nil

      expect {
        delete work_path(work_id)
      }.wont_change "Work.count"

      must_respond_with :not_found
    end
  end

  describe "upvote" do
    before do
      @user = User.create(username: "generic_name")

      @login_data = {
        user: {
          username: @user.username,
        },
      }
    end

    it "flashes an error if user is not logged in" do
      post logout_path
      expect(session[:user_id]).must_be_nil

      post upvote_path(@work)

      check_flash(expected_status = :error)

      must_respond_with :redirect
      must_redirect_to work_path(@work)
    end

    it "adds the user to works if new vote" do
      post login_path, params: @login_data
      expect(session[:user_id]).must_equal @user.id

      expect {
        post upvote_path(@work)
      }.must_change "@work.votes.count", +1

      check_flash

      must_respond_with :redirect
      must_redirect_to work_path(@work)
    end

    it "flashes an error if user already voted" do
      post login_path, params: @login_data
      expect(session[:user_id]).must_equal @user.id

      expect {
        post upvote_path(@work)
      }.must_change "@work.votes.count", +1

      check_flash

      post upvote_path(@work)

      check_flash(expected_status = :error)

      must_respond_with :redirect
      must_redirect_to work_path(@work)
    end
  end
end
