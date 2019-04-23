require "test_helper"

describe HomepagesController do
  describe "index" do
    it "can get index" do
      # Act
      get homepages_path

      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end
end
