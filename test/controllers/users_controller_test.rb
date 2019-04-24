require "test_helper"

describe UsersController do
  describe "index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
  end

  describe "new" do
  end

  describe "create" do
  end

  describe "edit" do
  end

  describe "update" do
  end

  describe "destroy" do
  end
end
