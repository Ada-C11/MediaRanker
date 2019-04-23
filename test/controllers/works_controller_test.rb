require "test_helper"

describe WorksController do
  describe "index" do
    it "can get to the root path" do
      get root_path

      must_respond_with :success
    end

    it "can get to the index path" do
      get works_path

      must_respond_with :success
    end
  end
  describe "show" do
    it "can get a valid work" do
      work = works(:one)

      get work_path(work.id)

      must_respond_with :success
    end

    it "will redirect for an invalid work" do
      get work_path(-1)

      must_respond_with :redirect
    end
  end
end
