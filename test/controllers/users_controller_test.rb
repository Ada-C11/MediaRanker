require "test_helper"

describe UsersController do
  it "should get index" do
    get users_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get users_show_url
    value(response).must_be :success?
  end

  it "allows a user to log in" do
  end

  it "allows a user to log out" do
  end

  it "allows you to create a user" do
  end

  it "wont let a user vote more than once for the same work" do
  end
end
