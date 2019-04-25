require "test_helper"

describe WorksController do
  it "should get index" do
    get works_url
    value(response).must_be :successful?
  end

  describe "show" do
    it "should get show" do
      valid_work_id = works(:one).id

      get works_url(valid_work_id)
      value(response).must_be :successful?
    end

    it "should give a flash notice instead if invalid work" do
      invalid_id = works(:one).id
      works(:one).destroy

      get work_path(invalid_id)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown work"
    end
  end 

  describe "create" do
  end

end
