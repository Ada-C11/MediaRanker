require "test_helper"

describe UsersController do
  describe "login_form" do 
    it "displays the login#show page" do
      get login_path

      must_respond_with :ok
    end
  end

  describe "log_in" do 
    it "allows a user to login " do 
      perform_login

      check_flash
      must_redirect_to root_path
    end

    it "creates a new user if they don't exist" do 
      perform_login

      login_data = {
        user: {
          username: "A User",
        },
      }

      
      expect{
        post login_path, params: login_data
      }.must_change "User.count", +1
    end

    it "doesn't allow a user without username" do 
      bad_login_data = {
        user: {
          username: ""
        }
      }

      expect {
        post login_path, params: bad_login_data
      }.wont_change "User.count"

      check_flash(:error)
      expect(session[:user_id]).must_be_nil
      must_redirect_to root_path
    end
  end

  describe "log_out" do 
    it "logs out a user if logged in " do 
      perform_login 

      post logout_path

      expect(session[:user_id]).must_be_nil
      expect(session[:user_name]).must_be_nil
      must_redirect_to root_path
    end
  end

  describe "show" do 
    it "shows a user showpage" do
      user = User.first
      get user_path(user.id)

      must_respond_with :ok
    end

    it "responds with 404 for nonextant user" do 
      user_id = 1337

      get user_path(user_id)

      must_respond_with :not_found
    end
  end

  describe "index" do 
    it "shows the all users list page" do 
      get works_path

      must_respond_with :ok
    end

    it "still renders page with no media present" do 
      User.destroy_all

      get works_path

      must_respond_with :ok
    end
  end
end
