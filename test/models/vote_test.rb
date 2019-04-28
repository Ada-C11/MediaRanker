require "test_helper"

describe Vote do
  before do
    user = users(:al)
    work = works(:a)
    @vote = Vote.new(
      user_id: user.id, work_id: work.id,
    )
  end

  it "passes validations with good data" do
    expect(@vote).must_be :valid?
  end
  it "belongs to a user and a work" do
    vote = votes(:vote4)
    expect(vote.user_id).must_equal users(:bal).id
    expect(vote.work_id).must_equal works(:a).id
  end
end
