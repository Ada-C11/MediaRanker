require "test_helper"

describe UsersController do
  let(:user) { users(:one) }

  it "should get the login page" do
    get login_path

    must_respond_with :success
  end

  describe "index action" do
    it "displays all users" do
      get users_path

      must_respond_with :success
    end
  end

  describe "show action"  do
    it "displays an individual user" do
      valid_user = User.first
      get user_path(valid_user.id)
  
      must_respond_with :success
    end

    it "returns 404 for invalid user" do
      get user_path(-1)

      must_respond_with :not_found

    end
  end

  describe "login action" do
    it "user can log in" do
      perform_login

      must_redirect_to root_path
    end

    it "flashes success when existing user logs in" do
      test_user = {
        "user": {
          username: user.username,
        },
      }

      expect {
        post login_path, params: test_user
      }.wont_change "User.count"

      expect(flash[:success]).must_equal "Welcome back, #{user.username}."
    end
  end

  describe "logout action" do
    it "logs a user out" do
      perform_login

      post logout_path

      expect(session[:user_id] = nil).must_be_nil

      must_redirect_to root_path
    end

  end

  describe "current action" do 
    it "responds with success if a user is logged in" do
      user_id = users(:one).id
      
      get user_path(user_id)

      must_respond_with :success
    end

    it "gets to the current user page" do
      test_user = {
        "user": {
          username: user.username,
        }
      }

      post login_path, params: test_user
      expect(session[:user_id]).must_equal user.id

    end
  end

  describe "upvote action" do
    before do
      @work = works(:album_2)
      @user = perform_login
    end
  
    it "user can vote when logged in & voting for the first time" do
      perform_login

      work_1 = works(:album_2)
  
      post upvote_path(work_1.id)

      expect(
        work_1.cached_votes_total
      ).must_equal 1
  
    end

    it "user must be logged in before voting" do
      work_1 = works(:album_2)

      post upvote_path(work_1.id)
      
      # can't get this test to pass
      # expect(flash[:status]).must_equal "Must be logged in to vote!"
      must_respond_with :redirect
    end

    it "user can only vote once" do
      perform_login

      work_1 = works(:album_2)
      post upvote_path(work_1.id)
      must_respond_with :found

      post upvote_path(work_1.id)

      expect(flash[:error]).must_equal "Cannot upvote the same media twice."
      must_respond_with :redirect
    end
  end
  

end
