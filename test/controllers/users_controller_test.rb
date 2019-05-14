require "test_helper"

describe UsersController do
  let (:user) {
    User.create(
      name: "chantal",
      join_date: Date.parse("1989-04-04"),
    )
  }

  describe "index" do
    it "can get the index path" do
      get users_path
      must_respond_with :success
    end
  end

  # describe "new" do
  #   it "returns status code 200" do
  #     get new_user_path
  #     must_respond_with :ok
  #   end
  # end

  # it "creates user" do
  #   expect {
  #     post users_url, params: { user: user_hash }
  #   }.must_change "User.count"

  #   must_redirect_to user_path(User.last)
  # end

  # describe "edit" do
  #   it "can edit an existing user" do
  #     get edit_user_path(user.name)
  #     must_respond_with :success
  #   end
  # end

  # describe "update" do
  #   it "updates user" do
  #     patch user_url(user.id), params: { user: user_hash }
  #     must_redirect_to users_path(user)
  #   end
  # end

  describe "show" do
    it "can get a valid user" do
      get users_path(user.name)
      must_respond_with :success
    end
  end

  describe "login_form" do
    it "is a new user form" do
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    it "logs in a new user" do
      login_hash = {
        user: {
          name: "Persephone",
        },
      }

      expect {
        post login_path, params: login_hash
      }.must_change "User.count"

      expect(session[:user_id]).must_equal User.last.id
    end

    it "logs in an existing user" do
      login_hash = {
        user: {
          name: user.name,
        },
      }

      expect {
        post login_path, params: login_hash
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end
  end

  describe "logout" do
    it "logs out a user" do
      login_hash = {
        user: {
          name: user.name,
        },
      }
      post login_path, params: login_hash
      expect(session[:user_id]).must_equal user.id

      post logout_path
      expect(session[:user_id]).must_be_nil
    end
  end

  describe "current" do
    it "responds with 200 ok for a logged-in user" do
      login_data = {
        user: {
          name: user.name,
        },
      }

      post login_path, params: login_data
      expect(session[:user_id]).must_equal user.id

      get current_user_path

      must_respond_with :ok
    end
  end
end
