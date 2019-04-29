require 'pp'
require "test_helper"

describe UsersController do
  before do
    @user = User.create!(
      username: "Rabbit",
    )
  end
  describe "index" do
    it "renders without crashing" do
      get users_path

      must_respond_with :ok
    end

    it "renders even if there are zero users" do
      User.destroy_all

      get users_path

      must_respond_with :ok
    end
  end

  describe "show" do
    it "returns a 404 status code if the user doesn't exist" do
      user_id = 12345

      get user_path(user_id)

      must_respond_with :not_found
    end

    it "works for a user that exists" do
      get user_path(@user.id)

      must_respond_with :ok
    end

  end

  describe 'login_form' do
    it 'Renders a new form to log in' do
      post login_path, params:{user: {username: 'Micki'}}

      must_redirect_to home_path
    end
  end

  describe 'login' do
    it 'Allows you to log in with a username' do
      post login_path, params:{user: {username: 'Micki'}}

      expect(session[:user_id]).wont_be_nil
      must_redirect_to home_path
    end

    it 'Creates a new user if first time user' do
      user = User.find_by(username: 'Random2')

      expect(user).must_be_nil

      post login_path, params:{user: {username: 'Random2'}}

      user = User.find_by(username: 'Random2')

      expect(user).wont_be_nil
    end
  end

  describe 'logout' do
    it 'logs you out' do
      post login_path, params:{user: {username: 'Micki'}}
      
      expect(session[:user_id]).wont_be_nil

      post logout_path
      
      expect(session[:user_id]).must_be_nil

      must_redirect_to home_path
    end
  end
end
