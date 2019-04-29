require "test_helper"

describe UsersController do
  it "should get Index" do
    get users_Index_url
    value(response).must_be :success?
  end

end
