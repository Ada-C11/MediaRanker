require "test_helper"

describe Vote do
  let(:vote) {
    Vote.new(
      user_id: User.first.id,
      work_id: Work.first.id,
    )
  }

  it "must be valid" do
    value(vote).must_be :valid?
  end
end
