require "test_helper"

describe WelcomeController do
  it "should get index" do
    get welcome_index_url
    value(response).must_be :success?
  end

end
