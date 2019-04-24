require "test_helper"

describe AlbumsController do
  it "should get index" do
    get albums_index_url
    value(response).must_be :success?
  end

end
