  require "test_helper"

  describe LandingController do

    it "should get index" do
      get root_path
      value(response).must_be :successful?
    end

  end
