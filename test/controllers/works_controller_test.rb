require "test_helper"

describe WorksController do
  it "should get index" do
    get works_path
    must_respond_with :success
  end

  it "should get show" do
    get work_path(works(:book1).id)
    must_respond_with :success
  end

  it "should get new" do
    get new_work_path
    must_respond_with :success
  end

  it "should get edit" do
    get edit_work_path(works(:book2).id)
    must_respond_with :success
  end

end