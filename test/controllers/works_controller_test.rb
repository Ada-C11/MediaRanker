require "test_helper"

describe WorksController do
  it "get works index page" do
    get works_path
    must_respond_with :success
  end
end
