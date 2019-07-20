require "test_helper"

describe HomepagesController do
  it "should get index" do
    get homepages_index_url

    must_respond_with :success
  end
end
