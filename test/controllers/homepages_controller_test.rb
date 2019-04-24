require "test_helper"

describe HomepagesController do
  describe "index" do
    it "should get index" do
      get homepages_index_path
      must_respond_with :success
    end
  end
end
