require "test_helper"

describe WorksController do
let (:work) {
  works(:movie)
}

  describe "index" do
    it "should get index" do
      get works_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid work" do
      get work_path(work.id)

      must_respond_with :success
    end

    it "will redirect for an invalid work" do
    invalid_id = -1
      get work_path(invalid_id)

      must_respond_with :redirect
    end
  end
end
