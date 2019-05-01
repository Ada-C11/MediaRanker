require "test_helper"

describe WorksController do
  it "should get index" do
    get works_path
    must_respond_with :success
  end

  describe "show" do
    it "should successfully show an existing and valid work" do
      get works_show_url
      value(response).must_be :success?
    end
  end

  it "should get edit" do
    get works_edit_url
    value(response).must_be :success?
  end

  it "should get delete" do
    get works_delete_url
    value(response).must_be :success?
  end

  it "should get create" do
    get works_create_url
    value(response).must_be :success?
  end
end
