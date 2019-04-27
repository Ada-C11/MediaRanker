require "test_helper"

describe UsersController do
  describe "users#index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  let(:user) { users(:one) }
  describe "users#show" do
    it "should get show with valid id" do
      id = user.id
      get user_path(id)
      must_respond_with :success
    end

    it "should return a 404 with invalid id" do
      invalid_id = -1
      get user_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "users#login_form" do
    it "will get to log in page" do
    end
  end

  #   describe "users#login" do
  #     it "will create a new user if username does not exist" do
  #     end

  #     it "will update session user to previously created user" do
  #     end
  #   end

  #   describe "user#logout" do
  #     it "will log out user" do
  #     end
  #   end

  #   #   it "should get new" do
  #   #     get users_new_url
  #   #     value(response).must_be :success?
  #   #   end

  #   #   it "should get create" do
  #   #     get users_create_url
  #   #     value(response).must_be :success?
  #   #   end

  #   # end
end
