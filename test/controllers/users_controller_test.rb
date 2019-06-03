require "test_helper"

describe UsersController do
  it "can get a list of all users" do
    get users_index_url
    must_respond_with :success
  end

  it "can show a user" do
    get users_show_url
    must_respond_with :success
  end
end
