require "test_helper"

describe UsersController do
  describe "users#index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "users#show" do
    it "should get show with valid id" do
    end

    it "should return a 404 with invalid id" do
    end
  end


  describe "users#login" do 
    it "will create a new user if username does not exist" do 
    end

    it "will update session user to previously created user" do
    end
  end

  describe "user#logout" do 
    it "will log out user" do 
    end
  end
  

  #   it "should get new" do
  #     get users_new_url
  #     value(response).must_be :success?
  #   end

  #   it "should get create" do
  #     get users_create_url
  #     value(response).must_be :success?
  #   end

  # end
end
