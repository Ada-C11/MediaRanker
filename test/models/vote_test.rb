require "test_helper"

describe Vote do
  before do
    @user = User.first

    @work = Work.first
  end

  it "must be valid" do
    vote = Vote.create(user_id: @user.id, work_id: @work.id)

    value(vote).must_be :valid?
  end

  it "is invalid if another vote exists with the same user_id and work_id" do
    vote = Vote.create(user_id: @user.id, work_id: @work.id)

    vote2 = Vote.create(user_id: @user.id, work_id: @work.id)
    expect(vote2).wont_be :valid?
  end
end
