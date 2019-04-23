require "test_helper"

describe WorksController do
  describe "works#index" do
    it "should get index" do
      get works_path
      must_respond_with :success
    end
  end


  #   it "should get show" do
  #     get works_show_url
  #     value(response).must_be :success?
  #   end

  #   it "should get new" do
  #     get works_new_url
  #     value(response).must_be :success?
  #   end

  #   it "should get create" do
  #     get works_create_url
  #     value(response).must_be :success?
  #   end

  #   it "should get update" do
  #     get works_update_url
  #     value(response).must_be :success?
  #   end

  #   it "should get edit" do
  #     get works_edit_url
  #     value(response).must_be :success?
  #   end
end
