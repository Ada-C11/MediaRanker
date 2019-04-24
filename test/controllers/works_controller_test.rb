require "test_helper"

describe WorksController do
  describe "index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should be OK to show an existing, valid work" do
      valid_work_id = works(:one).id
      get work_path(valid_work_id)
      must_respond_with :success
    end

    it "should give a flash notice instead of showing a non-existant, invalid work" do
      work = works(:two)
      invalid_work_id = work.id
      work.destroy
      get work_path(invalid_work_id)
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown work"
    end
  end

  # it "should get new" do
  #   get users_new_url
  #   value(response).must_be :success?
  # end

  # it "should get create" do
  #   get users_create_url
  #   value(response).must_be :success?
  # end

  # it "should get edit" do
  #   get users_new_url
  #   value(response).must_be :success?
  # end

  # it "should get update" do
  #   get users_new_url
  #   value(response).must_be :success?
  # end

  # it "should delete" do
  #   get users_create_url
  #   value(response).must_be :success?
  # end
end
