require "test_helper"

describe WorksController do
  it "can list all works" do
    get works_index_url
    value(response).must_be :success?
  end

  it "can show a work" do
    get works_show_url
    value(response).must_be :success?
  end

  it "can get new work url" do
    get works_new_url
    value(response).must_be :success?
  end

  it "can create a new work" do
    get works_create_url
    value(response).must_be :success?
  end

  it "can edit a work" do
    get works_edit_url
    value(response).must_be :success?
  end
end
