require "test_helper"

describe UsersController do
  it "displays the login#show page" do
    get login_path

    must_respond_with :ok
  end
end
