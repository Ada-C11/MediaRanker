require "test_helper"

describe Vote do
  it "must be valid" do
    work = works(:work_one)

    valid_work = work.valid?

    expect(valid_work).must_equal true
  end
end
