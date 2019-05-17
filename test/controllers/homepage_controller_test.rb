require "test_helper"

describe HomepageController do
  describe "index" do
    it "should get index" do
      # Action
      get root_path

      # Assert
      must_respond_with :success
    end
  end
end
