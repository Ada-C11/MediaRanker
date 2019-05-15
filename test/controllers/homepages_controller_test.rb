require "test_helper"

describe HomepagesController do
  describe "root" do
    it "can get the root" do

      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end
end
