require "test_helper"

describe HomepagesController do
  describe "index" do
    it "can get the homepage" do
      get root_path

      must_respond_with :success
    end
  end
end
