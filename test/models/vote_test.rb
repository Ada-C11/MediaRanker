require "test_helper"

describe Vote do
  before do 
    @vote = Vote.first 
  end 

  it "must be valid" do
    expect(@vote).must_be :valid?
  end

  it 'requires a present user' do
    invalid_vote = Vote.new(work: Work.first)
    expect(invalid_vote).wont_be :valid?
    expect(invalid_vote.errors.messages).must_include :user
    expect(invalid_vote.errors.messages).wont_include :work
  end 

  it 'requires a present work' do
    invalid_vote = Vote.new(user: User.first)
    expect(invalid_vote).wont_be :valid?

    expect(invalid_vote.errors.messages).must_include :work 
    expect(invalid_vote.errors.messages).wont_include :user
  end 

  it 'requires unique combination of user_id and work_id' do
    user = @vote.user
    work = @vote.work 

    invalid_vote = Vote.new(user: user, work: work)
    expect(invalid_vote).wont_be :valid?
    expect(invalid_vote.errors.messages).must_include :user_id
  end 

end
