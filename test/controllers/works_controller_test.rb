require "test_helper"

describe WorksController do
  describe "index" do
    it "can get to the root path" do
      get root_path

      must_respont_with :success
    end
  end
end
