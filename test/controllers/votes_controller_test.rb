require "test_helper"

describe VotesController do
  it "should get index" do
    get votes_index_url
    value(response).must_be :success?
  end

end
