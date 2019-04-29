require "test_helper"

describe HomepagesController do
  it "loads main page" do
    get root_path
    must_respond_with :success
  end

  it "loads main page even if there are no works" do
    Work.delete_all
    expect(Work.count).must_equal 0
    get root_path
    must_respond_with :success
  end
end
