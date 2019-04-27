require "test_helper"

describe HomepagesController do
  it "sends a 200 when directing to the homepage" do
    get root_path

    must_respond_with :ok
  end
end
