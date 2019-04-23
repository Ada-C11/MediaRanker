require "test_helper"

describe LandingController do

  require "test_helper"

  describe LandingController do
    it "should get index" do
      get landing_index_url
      value(response).must_be :success?
    end

  end
end
