require "test_helper"

describe WorksController do
  let(:work) { works(:war_and_peace) }

  describe "index" do
    it "can get index" do
      get works_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can show an existing valid work" do
      get work_path(work.id)

      must_respond_with :success
    end
  end

  describe "new" do
    it "can get the new page" do
      get new_work_path
      value(response).must_be :success?
    end
  end

  describe "create" do
    it "can create a new work" do
    end
  end

  describe "edit" do
    it "can edit an existing valid work" do
      get edit_work_path(work.id)

      must_respond_with :success
    end
  end

  describe "update" do
    it "can update an existing valid work" do
    end
  end

  describe "delete" do
    it "can delete an exisiting valid work" do
    end
  end
end
