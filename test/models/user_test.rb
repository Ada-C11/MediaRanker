require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    value(user).must_be :valid?
  end
end

describe 'has_voted?' do
  it 'can return true if user has already voted on the work' do
    work = user.votes.first.work_id
    result = user.has_voted?(work)

     expect(result).wont_be_nil
  end
end
