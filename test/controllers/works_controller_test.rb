require "test_helper"

describe WorksController do
  describe "index"do
    it "must be able to get index" do
      get works_path
      must_respond_with :success
    end
  end
end
