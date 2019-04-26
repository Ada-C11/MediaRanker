require "test_helper"

describe WorksController do
  describe "index" do
    it "should get index" do
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should get show" do
      get work_path(works(:hp1).id)
      must_respond_with :success
    end

    it "will respond with 404 if the work is not found" do
      work = works(:hp1)
      invalid_work_id = work.id
      work.destroy

      get work_path(invalid_work_id)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "should get new" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "should create new works" do
      work_hash = {
        work: {
          title: "test 3",
        },
      }
      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      must_respond_with :redirect
    end

    it "should respond with bad request if the work is missing a title" do
      work_hash = {
        work: {
          title: "",
        },
      }
      expect {
        post works_path, params: work_hash
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "should get edit" do
      get edit_work_path(works(:hp1).id)

      must_respond_with :success
    end

    it "should respond with 404 if the work doesn't exist" do
      work = works(:hp1)
      invalid_work_id = work.id
      work.destroy

      get edit_work_path(invalid_work_id)

      must_respond_with :not_found
    end
  end

  describe "update" do
    it "should update works" do
      update_work_hash = {
        work: {
          title: "test 2",
        },
      }
      patch work_path(works(:hp1)), params: update_work_hash

      must_respond_with :redirect
      expect(Work.find_by(title: "test 2")).wont_be_nil
    end

    it "should respond with a bad request if the title is empty" do
      bad_work_hash = {
        work: {
          title: "",
        },
      }
      patch work_path(works(:hp1)), params: bad_work_hash

      must_respond_with :bad_request
      expect(Work.find_by(title: "test 2")).must_be_nil
    end

    it "should respond with not found if the work isn't found" do
      work_hash = {
        work: {
          title: "test 2",
        },
      }

      work = works(:hp1)
      invalid_work_id = work.id
      work.destroy

      patch work_path(invalid_work_id), params: work_hash

      must_respond_with :not_found
      expect(Work.find_by(title: "test 2")).must_be_nil
    end
  end

  describe "destory" do
    it "should destroy works" do
      expect {
        delete work_path(works(:hp1).id)
      }.must_change "Work.count", -1

      must_respond_with :redirect
    end

    it "should respond with 404 if the work does not exist" do
      work = works(:hp1)
      invalid_work_id = work.id
      work.destroy

      expect {
        delete work_path(invalid_work_id)
      }.wont_change "Work.count"

      must_respond_with :not_found
    end
  end
end
