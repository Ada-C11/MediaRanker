require "test_helper"

describe WorksController do
  let(:work) {
    Work.create(
      category: "book",
      title: "the witching hour",
      creator: "anne rice",
      publication_year: Date.strptime("1989", "%Y"),
      description: "witch coven in nola",
    )
  }

  let(:work_hash) {
    {
      category: "book",
      title: "the sorcerors stone",
      creator: "jk rowling",
      publication_year: "1998",
      description: "harrys first year at hogwarts",
    }
  }

  def login
    # create a user.
    user = User.create(
      name: "chantal",
    )
    # set user for session
    post login_path, params: { user: { name: user.name } }
    return user
  end

  describe "index" do
    it "can get the index path" do
      get works_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "returns status code 200" do
      get new_work_path
      must_respond_with :ok
    end
  end

  describe "create" do
    it "creates work" do
      expect {
        post works_path, params: { work: work_hash }
      }.must_change "Work.count"

      must_redirect_to works_path(Work.last)
    end
  end

  describe "edit" do
    it "can edit an existing work" do
      get edit_work_path(work.id)
      must_respond_with :success
    end
  end

  describe "update" do
    it "updates work" do
      patch work_path(work.id), params: { work: work_hash }
      must_redirect_to works_path(work)
    end
  end

  describe "show" do
    it "can get a valid work" do
      get works_path(work.id)
      must_respond_with :success
    end
  end

  describe "destroy" do
    it "destroys the work from the database" do
      delete work_path(work)

      must_respond_with :redirect
      must_redirect_to works_path

      after_title = Work.find_by(title: work.title)
      expect(after_title).must_be_nil
    end
  end

  describe "vote" do
    it "casts a vote" do
      user = login
      # pass a value
      value = -1

      expect {
        post vote_path(work.id), params: { value: value.to_s }
      }.must_change "Vote.count", 1
      # Ensure a user can vote only once.
      expect {
        post vote_path(work.id), params: { value: value.to_s }
      }.wont_change "Vote.count"

      vote = Vote.last
      expect(vote.value).must_equal value

      #must_redirect_to
    end

    it "must be logged in to vote" do
      expect {
        post vote_path(work.id)
      }.wont_change "Vote.count"
      check_flash(:error)
      #must_redirect_to
    end
  end

  describe "homepage" do
    it "displays a homepage" do
      get home_path(work)
      must_respond_with :success
    end
  end

  describe "current_user" do
    it "is the current user" do
      user = login
      current_user = User.find_by(id: session[:user_id])
      expect(current_user.id).must_equal user.id
    end
  end
end
